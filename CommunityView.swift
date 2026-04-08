import SwiftUI
import Foundation

// MARK: - Supabase Config
private enum SupabaseConfig {
    static let url = "https://ntcmrgusdcfsmhpncoq.supabase.co"
    static let key = "sb_publishable_ddkmvaA3kH7ZxWsX7bxIqg_DJLP6nMp"
}

// MARK: - Waitlist Count Response
private struct WaitlistCountResponse: Decodable {
    let count: Int
}

// MARK: - CommunityViewModel
@MainActor
class CommunityViewModel: ObservableObject {
    @Published var spotsClaimedCount: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    /// Fetches COUNT(DISTINCT email) from the waitlist table via Supabase REST API.
    /// Uses the Supabase `select=email.count()` with `Prefer: count=exact` header
    /// to get a deduplicated count.
    func fetchWaitlistCount() async {
        isLoading = true
        errorMessage = nil

        // Use RPC call for DISTINCT count, or use the REST endpoint with exact count header
        // Supabase REST: GET /rest/v1/waitlist?select=email
        // With Prefer: count=exact header, the count comes in the Content-Range header
        // For DISTINCT, we use an RPC function or a workaround

        // Approach: Use Supabase RPC endpoint for distinct count
        // If you have an RPC function set up, use that. Otherwise, we use the
        // select=email approach and deduplicate client-side for accuracy.

        guard let url = URL(string: "\(SupabaseConfig.url)/rest/v1/waitlist?select=email") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(SupabaseConfig.key, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(SupabaseConfig.key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode array of email objects
            struct EmailRow: Decodable {
                let email: String
            }

            let rows = try JSONDecoder().decode([EmailRow].self, from: data)

            // Count DISTINCT emails
            let uniqueEmails = Set(rows.map { $0.email.lowercased() })
            spotsClaimedCount = uniqueEmails.count

        } catch {
            errorMessage = "Could not load count"
            print("Waitlist count error: \(error)")
        }

        isLoading = false
    }
}

// MARK: - CommunityView
struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()

    private let totalSpots = 100

    var body: some View {
        VStack(spacing: 16) {
            Text("Join the Community")
                .font(.custom("PlayfairDisplay-Bold", size: 28))
                .foregroundColor(.primary)

            Text("Be among the first \(totalSpots) members")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Spots counter
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 8)
            } else {
                Text("\(viewModel.spotsClaimedCount) of \(totalSpots) spots claimed")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 39/255, green: 174/255, blue: 96/255))
                    .padding(.top, 8)

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 10)

                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 39/255, green: 174/255, blue: 96/255))
                            .frame(
                                width: geo.size.width * CGFloat(min(viewModel.spotsClaimedCount, totalSpots)) / CGFloat(totalSpots),
                                height: 10
                            )
                            .animation(.easeInOut(duration: 0.6), value: viewModel.spotsClaimedCount)
                    }
                }
                .frame(height: 10)
                .padding(.horizontal, 40)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 32)
        .onAppear {
            Task {
                await viewModel.fetchWaitlistCount()
            }
        }
    }
}

#Preview {
    CommunityView()
}
