import SwiftUI

// MARK: - ★ RECIPES VIEW ★
// 30 gut-brain optimized recipes across 4 categories

enum RecipeCategory: String, CaseIterable, Identifiable {
    case fermented = "Fermented"
    case prebiotic = "Prebiotic"
    case gutHealing = "Gut Healing"
    case brainFoods = "Brain Foods"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .fermented: return "flask.fill"
        case .prebiotic: return "leaf.fill"
        case .gutHealing: return "heart.circle.fill"
        case .brainFoods: return "brain"
        }
    }
}

struct GutRecipe: Identifiable {
    let id = UUID()
    let name: String
    let category: RecipeCategory
    let gutBenefit: String
    let prepTime: String
    let probiotics: Double
    let fiber: Double
    let calories: Double
    let icon: String
    let ingredients: [String]
    let steps: [String]
    let scienceNote: String
    let imageURL: URL?

    init(name: String, category: RecipeCategory, gutBenefit: String, prepTime: String, probiotics: Double, fiber: Double, calories: Double, icon: String, ingredients: [String], steps: [String], scienceNote: String = "", imageURL: String? = nil) {
        self.name = name
        self.category = category
        self.gutBenefit = gutBenefit
        self.prepTime = prepTime
        self.probiotics = probiotics
        self.fiber = fiber
        self.calories = calories
        self.icon = icon
        self.ingredients = ingredients
        self.steps = steps
        self.scienceNote = scienceNote
        self.imageURL = imageURL.flatMap { URL(string: $0) }
    }
}

// MARK: - All 30 Recipes

private let allRecipes: [GutRecipe] = [
    // ── FERMENTED (8) ──
    GutRecipe(name: "Kefir Berry Smoothie", category: .fermented, gutBenefit: "+2g probiotics", prepTime: "5 min", probiotics: 2.0, fiber: 2.0, calories: 180, icon: "cup.and.saucer.fill",
        ingredients: ["1 cup kefir", "1/2 cup mixed berries", "1 tbsp honey", "1/2 banana"],
        steps: ["Add kefir and berries to blender", "Add honey and banana", "Blend until smooth", "Pour and enjoy immediately"],
        scienceNote: "Kefir contains 30+ strains of bacteria and yeast, making it one of the most diverse probiotic foods available.",
        imageURL: "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800"),

    GutRecipe(name: "Kimchi Fried Rice", category: .fermented, gutBenefit: "+3g probiotics", prepTime: "15 min", probiotics: 3.0, fiber: 2.0, calories: 320, icon: "flame.fill",
        ingredients: ["2 cups cooked rice", "1 cup kimchi (chopped)", "2 eggs", "1 tbsp sesame oil", "2 green onions", "1 tbsp soy sauce"],
        steps: ["Heat sesame oil in a large pan", "Add chopped kimchi and stir-fry 3 min", "Add rice and soy sauce, toss to combine", "Push rice aside, scramble eggs in pan", "Mix together and top with green onions"],
        scienceNote: "Kimchi's Lactobacillus strains survive cooking and support GABA production in the gut.",
        imageURL: "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800"),

    GutRecipe(name: "Miso Soup", category: .fermented, gutBenefit: "+1g probiotics", prepTime: "10 min", probiotics: 1.0, fiber: 1.0, calories: 85, icon: "mug.fill",
        ingredients: ["2 tbsp white miso paste", "3 cups water", "1/2 block soft tofu (cubed)", "2 green onions (sliced)", "1 sheet nori (torn)"],
        steps: ["Bring water to a gentle simmer", "Dissolve miso paste in a small amount of warm water", "Add tofu cubes to the pot", "Stir in miso mixture (don't boil)", "Top with green onions and nori"],
        scienceNote: "Miso's Aspergillus oryzae produces enzymes that aid digestion and nutrient absorption.",
        imageURL: "https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800"),

    GutRecipe(name: "Sauerkraut Salad", category: .fermented, gutBenefit: "+2g probiotics", prepTime: "5 min", probiotics: 2.0, fiber: 3.0, calories: 120, icon: "leaf.fill",
        ingredients: ["1 cup raw sauerkraut", "2 cups mixed greens", "1/2 avocado (sliced)", "1 tbsp olive oil", "1 tbsp apple cider vinegar", "Salt and pepper"],
        steps: ["Toss mixed greens on a plate", "Top with sauerkraut and avocado slices", "Drizzle olive oil and apple cider vinegar", "Season with salt and pepper"],
        scienceNote: "Raw sauerkraut contains Lactobacillus plantarum, which produces serotonin precursors in the gut.",
        imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800"),

    GutRecipe(name: "Tempeh Stir Fry", category: .fermented, gutBenefit: "+4g probiotics", prepTime: "20 min", probiotics: 4.0, fiber: 3.0, calories: 380, icon: "flame.fill",
        ingredients: ["200g tempeh (cubed)", "1 cup broccoli florets", "1 red bell pepper (sliced)", "2 tbsp soy sauce", "1 tbsp sesame oil", "1 tsp ginger (grated)", "Brown rice to serve"],
        steps: ["Cube tempeh and pan-fry in sesame oil until golden", "Add ginger and stir 30 seconds", "Add broccoli and bell pepper, stir-fry 4 min", "Add soy sauce and toss to coat", "Serve over brown rice"],
        scienceNote: "Tempeh fermentation creates bioactive peptides that support gut barrier integrity.",
        imageURL: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800"),

    GutRecipe(name: "Yogurt Parfait", category: .fermented, gutBenefit: "+3g probiotics", prepTime: "5 min", probiotics: 3.0, fiber: 3.0, calories: 220, icon: "cup.and.saucer.fill",
        ingredients: ["1 cup Greek yogurt", "1/4 cup granola", "1/2 cup mixed berries", "1 tbsp honey", "1 tbsp chia seeds"],
        steps: ["Layer yogurt in a glass", "Add granola and berries", "Drizzle with honey", "Top with chia seeds"],
        scienceNote: "Greek yogurt's Lactobacillus and Streptococcus strains directly support serotonin synthesis.",
        imageURL: "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800"),

    GutRecipe(name: "Kombucha Vinaigrette Salad", category: .fermented, gutBenefit: "+1g probiotics", prepTime: "10 min", probiotics: 1.0, fiber: 4.0, calories: 150, icon: "leaf.fill",
        ingredients: ["3 cups arugula", "1/4 cup kombucha", "2 tbsp olive oil", "1 tbsp Dijon mustard", "1/2 cup cherry tomatoes", "1/4 cup walnuts"],
        steps: ["Whisk kombucha, olive oil, and mustard for dressing", "Toss arugula with cherry tomatoes", "Add walnuts", "Drizzle dressing and toss gently"],
        scienceNote: "Kombucha's organic acids create an acidic environment that supports beneficial gut bacteria.",
        imageURL: "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800"),

    GutRecipe(name: "Pickled Veggie Bowl", category: .fermented, gutBenefit: "+2g probiotics", prepTime: "15 min", probiotics: 2.0, fiber: 5.0, calories: 200, icon: "leaf.fill",
        ingredients: ["1 cup brown rice", "1/2 cup pickled carrots", "1/2 cup pickled radish", "1/4 cup pickled ginger", "1 avocado (sliced)", "Sesame seeds", "Soy sauce"],
        steps: ["Cook brown rice and let cool slightly", "Arrange pickled vegetables on top", "Add sliced avocado", "Sprinkle sesame seeds and drizzle soy sauce"],
        scienceNote: "Naturally fermented pickled vegetables contain diverse Lactobacillus strains that colonize the gut.",
        imageURL: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800"),

    // ── PREBIOTIC (8) ──
    GutRecipe(name: "Overnight Oats with Banana", category: .prebiotic, gutBenefit: "+5g fiber", prepTime: "5 min", probiotics: 0, fiber: 5.0, calories: 280, icon: "moon.fill",
        ingredients: ["1/2 cup rolled oats", "1/2 cup milk", "1/4 cup yogurt", "1 banana (sliced)", "1 tbsp chia seeds", "1 tbsp honey"],
        steps: ["Mix oats, milk, and yogurt in a jar", "Add chia seeds and honey", "Top with banana slices", "Refrigerate overnight", "Eat cold in the morning"],
        scienceNote: "Oats contain beta-glucan, a prebiotic fiber that feeds Bifidobacteria and boosts short-chain fatty acid production.",
        imageURL: "https://images.unsplash.com/photo-1571748982800-fa51082c2224?w=800"),

    GutRecipe(name: "Garlic Roasted Asparagus", category: .prebiotic, gutBenefit: "+4g fiber", prepTime: "20 min", probiotics: 0, fiber: 4.0, calories: 95, icon: "leaf.fill",
        ingredients: ["1 bunch asparagus", "4 cloves garlic (minced)", "2 tbsp olive oil", "Salt and pepper", "Lemon zest"],
        steps: ["Preheat oven to 400F", "Trim asparagus and toss with oil and garlic", "Spread on baking sheet", "Roast 15 minutes until tender", "Finish with lemon zest"],
        scienceNote: "Asparagus is rich in inulin, a prebiotic that specifically feeds Bifidobacteria linked to mood regulation.",
        imageURL: "https://images.unsplash.com/photo-1515516969-d4008c6ea5b7?w=800"),

    GutRecipe(name: "Leek and Potato Soup", category: .prebiotic, gutBenefit: "+6g fiber", prepTime: "30 min", probiotics: 0, fiber: 6.0, calories: 210, icon: "mug.fill",
        ingredients: ["3 leeks (sliced)", "2 potatoes (cubed)", "4 cups vegetable broth", "1 tbsp butter", "1/4 cup cream", "Salt, pepper, chives"],
        steps: ["Melt butter and cook leeks until soft", "Add potatoes and broth", "Simmer 20 minutes until tender", "Blend until smooth", "Stir in cream, garnish with chives"],
        scienceNote: "Leeks contain fructo-oligosaccharides, prebiotics that increase Lactobacillus populations in the gut.",
        imageURL: "https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800"),

    GutRecipe(name: "Jerusalem Artichoke Chips", category: .prebiotic, gutBenefit: "+8g fiber", prepTime: "25 min", probiotics: 0, fiber: 8.0, calories: 180, icon: "leaf.fill",
        ingredients: ["4 Jerusalem artichokes", "2 tbsp olive oil", "1 tsp sea salt", "1/2 tsp rosemary"],
        steps: ["Preheat oven to 375F", "Slice artichokes thinly with a mandoline", "Toss with olive oil, salt, rosemary", "Spread on parchment-lined baking sheet", "Bake 20 min until crispy"],
        scienceNote: "Jerusalem artichokes have the highest inulin content of any vegetable \u{2014} up to 76% of dry weight.",
        imageURL: "https://images.unsplash.com/photo-1518977956812-cd3dbadaaf31?w=800"),

    GutRecipe(name: "Chicory Root Latte", category: .prebiotic, gutBenefit: "+3g fiber", prepTime: "5 min", probiotics: 0, fiber: 3.0, calories: 45, icon: "cup.and.saucer.fill",
        ingredients: ["2 tbsp roasted chicory root granules", "1 cup hot water", "1/4 cup oat milk", "1/2 tsp cinnamon", "1 tsp honey (optional)"],
        steps: ["Steep chicory root in hot water 3 minutes", "Heat oat milk and froth", "Pour chicory into mug", "Top with frothed milk and cinnamon"],
        scienceNote: "Chicory root is 65% inulin by weight, making it the most concentrated prebiotic food source.",
        imageURL: "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800"),

    GutRecipe(name: "Dandelion Green Salad", category: .prebiotic, gutBenefit: "+4g fiber", prepTime: "10 min", probiotics: 0, fiber: 4.0, calories: 85, icon: "leaf.fill",
        ingredients: ["2 cups dandelion greens", "1/2 cup strawberries (sliced)", "2 tbsp goat cheese", "1 tbsp balsamic vinegar", "1 tbsp olive oil", "1 tbsp pumpkin seeds"],
        steps: ["Wash and dry dandelion greens", "Arrange on plate with strawberries", "Crumble goat cheese on top", "Whisk balsamic and olive oil, drizzle", "Top with pumpkin seeds"],
        scienceNote: "Dandelion greens contain inulin and promote bile production, supporting fat digestion and gut motility.",
        imageURL: "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800"),

    GutRecipe(name: "Onion and Lentil Dal", category: .prebiotic, gutBenefit: "+9g fiber", prepTime: "35 min", probiotics: 0, fiber: 9.0, calories: 290, icon: "flame.fill",
        ingredients: ["1 cup red lentils", "2 onions (diced)", "3 cloves garlic", "1 tsp turmeric", "1 tsp cumin", "1 can coconut milk", "Salt, cilantro"],
        steps: ["Cook lentils in water until soft", "In a separate pan, fry onions and garlic until golden", "Add turmeric and cumin to onions", "Combine lentils and onion mixture", "Stir in coconut milk, simmer 10 min", "Garnish with cilantro"],
        scienceNote: "Onions are rich in fructo-oligosaccharides and lentils provide resistant starch \u{2014} both feed beneficial gut bacteria.",
        imageURL: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800"),

    GutRecipe(name: "Green Banana Smoothie", category: .prebiotic, gutBenefit: "+6g fiber", prepTime: "5 min", probiotics: 0, fiber: 6.0, calories: 195, icon: "cup.and.saucer.fill",
        ingredients: ["1 green (unripe) banana", "1 cup spinach", "1/2 cup almond milk", "1 tbsp almond butter", "1/2 tsp cinnamon", "Ice cubes"],
        steps: ["Add all ingredients to blender", "Blend until smooth", "Add ice for thickness", "Pour and drink immediately"],
        scienceNote: "Green bananas contain resistant starch that feeds butyrate-producing bacteria, directly supporting gut lining repair.",
        imageURL: "https://images.unsplash.com/photo-1638176066666-ffb2f013c7dd?w=800"),

    // ── GUT HEALING (7) ──
    GutRecipe(name: "Bone Broth Ramen", category: .gutHealing, gutBenefit: "+collagen", prepTime: "20 min", probiotics: 0, fiber: 2.0, calories: 310, icon: "mug.fill",
        ingredients: ["2 cups bone broth", "1 pack ramen noodles", "1 soft-boiled egg", "2 green onions", "1 tbsp soy sauce", "1 tsp sesame oil", "Nori sheets"],
        steps: ["Heat bone broth until simmering", "Cook noodles according to package", "Place noodles in bowl, pour broth over", "Top with halved soft-boiled egg", "Add green onions, nori, sesame oil"],
        scienceNote: "Bone broth provides glutamine and collagen peptides that directly repair intestinal lining tight junctions.",
        imageURL: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800"),

    GutRecipe(name: "Turmeric Golden Milk", category: .gutHealing, gutBenefit: "+anti-inflammatory", prepTime: "5 min", probiotics: 0, fiber: 0, calories: 120, icon: "cup.and.saucer.fill",
        ingredients: ["1 cup oat milk", "1 tsp turmeric powder", "1/2 tsp cinnamon", "1/4 tsp black pepper", "1 tsp honey", "1/2 tsp coconut oil"],
        steps: ["Heat oat milk in a saucepan", "Whisk in turmeric, cinnamon, and pepper", "Add coconut oil and honey", "Simmer 3 minutes (don't boil)", "Strain and serve warm"],
        scienceNote: "Curcumin in turmeric reduces gut inflammation. Black pepper increases absorption by 2000%.",
        imageURL: "https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=800"),

    GutRecipe(name: "Aloe Vera Juice Blend", category: .gutHealing, gutBenefit: "+gut lining", prepTime: "5 min", probiotics: 0, fiber: 0, calories: 65, icon: "drop.fill",
        ingredients: ["2 tbsp aloe vera juice", "1 cup coconut water", "1/2 cucumber (peeled)", "Juice of 1 lime", "Fresh mint leaves"],
        steps: ["Blend cucumber with coconut water", "Add aloe vera juice and lime", "Strain if desired", "Garnish with mint", "Serve cold"],
        scienceNote: "Aloe vera's acemannan polysaccharides coat and soothe the gut lining while reducing intestinal inflammation.",
        imageURL: "https://images.unsplash.com/photo-1556881286-fc6915169721?w=800"),

    GutRecipe(name: "Slippery Elm Porridge", category: .gutHealing, gutBenefit: "+gut lining", prepTime: "10 min", probiotics: 0, fiber: 4.0, calories: 180, icon: "bowl.fill",
        ingredients: ["1/2 cup rolled oats", "1 tbsp slippery elm powder", "1 cup water", "1/2 cup almond milk", "1 tbsp maple syrup", "Cinnamon"],
        steps: ["Combine oats and water in a pot", "Bring to a simmer, stir in slippery elm", "Cook 5 minutes stirring constantly", "Add almond milk and maple syrup", "Top with cinnamon"],
        scienceNote: "Slippery elm creates a mucilage coating that protects inflamed gut tissue and promotes healing.",
        imageURL: "https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=800"),

    GutRecipe(name: "Ginger Lemon Tea", category: .gutHealing, gutBenefit: "+digestion", prepTime: "5 min", probiotics: 0, fiber: 0, calories: 25, icon: "mug.fill",
        ingredients: ["1 inch fresh ginger (sliced)", "Juice of 1/2 lemon", "2 cups hot water", "1 tsp honey"],
        steps: ["Slice ginger into thin coins", "Steep in hot water 5 minutes", "Squeeze in lemon juice", "Stir in honey", "Sip slowly"],
        scienceNote: "Ginger's gingerols accelerate gastric emptying and reduce nausea by acting on serotonin receptors in the gut.",
        imageURL: "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800"),

    GutRecipe(name: "Collagen Berry Smoothie", category: .gutHealing, gutBenefit: "+collagen", prepTime: "5 min", probiotics: 0, fiber: 3.0, calories: 240, icon: "cup.and.saucer.fill",
        ingredients: ["1 scoop collagen peptides", "1 cup mixed berries", "1/2 cup almond milk", "1/2 banana", "1 tbsp flaxseed"],
        steps: ["Add all ingredients to blender", "Blend until smooth", "Pour into glass", "Enjoy immediately"],
        scienceNote: "Collagen peptides provide glycine and proline, amino acids essential for rebuilding the intestinal lining.",
        imageURL: "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800"),

    GutRecipe(name: "Marshmallow Root Tea", category: .gutHealing, gutBenefit: "+gut lining", prepTime: "10 min", probiotics: 0, fiber: 0, calories: 15, icon: "mug.fill",
        ingredients: ["1 tbsp dried marshmallow root", "2 cups hot water", "1 tsp honey (optional)", "Lemon slice"],
        steps: ["Add marshmallow root to a teapot", "Pour hot water over and steep 10 minutes", "Strain into mug", "Add honey and lemon if desired"],
        scienceNote: "Marshmallow root's mucilage coats the GI tract, reducing inflammation and protecting against acid damage.",
        imageURL: "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800"),

    // ── BRAIN FOODS (7) ──
    GutRecipe(name: "Salmon Avocado Bowl", category: .brainFoods, gutBenefit: "+omega-3", prepTime: "15 min", probiotics: 0, fiber: 5.0, calories: 420, icon: "fish.fill",
        ingredients: ["1 salmon fillet", "1 avocado (sliced)", "1 cup brown rice", "1/2 cup edamame", "Soy sauce", "Sesame seeds", "Pickled ginger"],
        steps: ["Cook brown rice", "Pan-sear salmon 4 min per side", "Arrange rice in bowl", "Top with flaked salmon and avocado", "Add edamame, ginger, sesame seeds", "Drizzle soy sauce"],
        scienceNote: "Salmon's EPA and DHA omega-3s cross the blood-brain barrier and reduce neuroinflammation, improving focus and mood.",
        imageURL: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800"),

    GutRecipe(name: "Blueberry Walnut Oatmeal", category: .brainFoods, gutBenefit: "+antioxidants", prepTime: "10 min", probiotics: 0, fiber: 6.0, calories: 340, icon: "bowl.fill",
        ingredients: ["1/2 cup rolled oats", "1 cup water", "1/2 cup blueberries", "2 tbsp walnuts (chopped)", "1 tbsp honey", "Cinnamon"],
        steps: ["Cook oats in water until creamy", "Top with blueberries and walnuts", "Drizzle honey", "Sprinkle cinnamon"],
        scienceNote: "Blueberry anthocyanins improve memory and walnuts provide ALA omega-3s that support neurotransmitter function.",
        imageURL: "https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=800"),

    GutRecipe(name: "Dark Chocolate Chia Pudding", category: .brainFoods, gutBenefit: "+magnesium", prepTime: "5 min", probiotics: 0, fiber: 8.0, calories: 280, icon: "cup.and.saucer.fill",
        ingredients: ["3 tbsp chia seeds", "1 cup almond milk", "1 tbsp cocoa powder", "1 tbsp maple syrup", "Dark chocolate shavings"],
        steps: ["Mix chia seeds, milk, cocoa, and maple syrup", "Stir well to prevent clumping", "Refrigerate 4 hours or overnight", "Top with dark chocolate shavings"],
        scienceNote: "Dark chocolate's flavonoids increase cerebral blood flow. Chia seeds provide fiber that feeds serotonin-producing gut bacteria.",
        imageURL: "https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=800"),

    GutRecipe(name: "Sardine Toast", category: .brainFoods, gutBenefit: "+omega-3", prepTime: "5 min", probiotics: 0, fiber: 2.0, calories: 290, icon: "fish.fill",
        ingredients: ["1 can sardines in olive oil", "2 slices sourdough bread", "1/2 lemon", "1 tbsp capers", "Fresh parsley", "Red pepper flakes"],
        steps: ["Toast sourdough bread", "Arrange sardines on toast", "Squeeze lemon juice over", "Top with capers, parsley, pepper flakes"],
        scienceNote: "Sardines provide more omega-3 per serving than salmon, plus vitamin D which regulates gut immune function.",
        imageURL: "https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800"),

    GutRecipe(name: "Lion's Mane Mushroom Stir Fry", category: .brainFoods, gutBenefit: "+NGF", prepTime: "20 min", probiotics: 0, fiber: 3.0, calories: 195, icon: "leaf.fill",
        ingredients: ["200g lion's mane mushroom", "1 tbsp butter", "2 cloves garlic", "1 tbsp soy sauce", "Fresh thyme", "Black pepper"],
        steps: ["Tear mushroom into bite-sized pieces", "Melt butter in pan over medium heat", "Add mushroom and cook 5 min until golden", "Add garlic and thyme, cook 2 min", "Finish with soy sauce and pepper"],
        scienceNote: "Lion's mane contains hericenones and erinacines that stimulate Nerve Growth Factor (NGF) production in the brain.",
        imageURL: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800"),

    GutRecipe(name: "Brazil Nut Smoothie", category: .brainFoods, gutBenefit: "+selenium", prepTime: "5 min", probiotics: 0, fiber: 3.0, calories: 310, icon: "cup.and.saucer.fill",
        ingredients: ["3 Brazil nuts", "1 banana", "1 cup oat milk", "1 tbsp cacao nibs", "1 tsp maca powder", "1 tbsp honey"],
        steps: ["Add Brazil nuts and oat milk to blender", "Add banana, cacao nibs, and maca", "Blend until smooth", "Drizzle honey on top"],
        scienceNote: "Just 2 Brazil nuts provide a full day's selenium, essential for thyroid function and neurotransmitter synthesis.",
        imageURL: "https://images.unsplash.com/photo-1638176066666-ffb2f013c7dd?w=800"),

    GutRecipe(name: "Matcha Avocado Pudding", category: .brainFoods, gutBenefit: "+L-theanine", prepTime: "10 min", probiotics: 0, fiber: 5.0, calories: 220, icon: "cup.and.saucer.fill",
        ingredients: ["1 ripe avocado", "1 tsp matcha powder", "2 tbsp maple syrup", "1/4 cup coconut cream", "Pistachios for topping"],
        steps: ["Blend avocado until smooth", "Add matcha, maple syrup, and coconut cream", "Blend until creamy and uniform green", "Spoon into bowls", "Top with crushed pistachios"],
        scienceNote: "Matcha's L-theanine crosses the blood-brain barrier, promoting alpha brain waves for calm focus without drowsiness.",
        imageURL: "https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=800"),
]

// MARK: - Recipes List with Category Tabs

struct RecipesView: View {
    @State private var selectedCategory: RecipeCategory = .fermented

    private var filteredRecipes: [GutRecipe] {
        allRecipes.filter { $0.category == selectedCategory }
    }

    var body: some View {
        ZStack {
            Color.biomeCream.ignoresSafeArea()

            VStack(spacing: 0) {
                // Category tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(RecipeCategory.allCases) { category in
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedCategory = category
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: category.icon)
                                        .font(.system(size: 11))
                                    Text(category.rawValue)
                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(selectedCategory == category ? .white : Color.deepForest)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 9)
                                .background(
                                    Capsule().fill(selectedCategory == category ? AnyShapeStyle(Color.darkGreen) : AnyShapeStyle(.ultraThinMaterial))
                                )
                                .overlay(
                                    Capsule().stroke(Color.white.opacity(selectedCategory == category ? 0 : 0.3), lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                RecipeCard(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Gut-Friendly Recipes")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Recipe Card

struct RecipeCard: View {
    let recipe: GutRecipe

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.darkGreen.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: recipe.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.darkGreen)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.deepForest)

                HStack(spacing: 12) {
                    Text(recipe.gutBenefit)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.darkGreen)

                    Text(recipe.prepTime)
                        .font(.system(size: 13, design: .rounded))
                        .foregroundColor(Color.ouraGray)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.ouraLightGray)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.06), radius: 10, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Recipe Detail

struct RecipeDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var logged = false
    let recipe: GutRecipe

    private var recipeIconFallback: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.darkGreen.opacity(0.1))
            .frame(height: 100)
            .overlay(
                Image(systemName: recipe.icon)
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color.darkGreen)
            )
    }

    var body: some View {
        ZStack {
            Color.biomeCream.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        if let url = recipe.imageURL {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .overlay(
                                            VStack {
                                                Spacer()
                                                LinearGradient(
                                                    colors: [Color.darkGreen.opacity(0.6), .clear],
                                                    startPoint: .bottom,
                                                    endPoint: .top
                                                )
                                                .frame(height: 80)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 18))
                                        )
                                case .failure:
                                    recipeIconFallback
                                @unknown default:
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.ouraLightGray.opacity(0.15))
                                        .frame(height: 200)
                                }
                            }
                        } else {
                            recipeIconFallback
                        }

                        HStack(spacing: 16) {
                            StatPill(label: recipe.gutBenefit, color: Color.darkGreen)
                            StatPill(label: recipe.prepTime, color: Color.ouraGray)
                            StatPill(label: "\(Int(recipe.calories)) cal", color: Color.ouraGray)
                        }
                    }

                    // Science note
                    if !recipe.scienceNote.isEmpty {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "brain")
                                .font(.system(size: 14))
                                .foregroundColor(Color.darkGreen)
                                .padding(.top, 2)
                            Text(recipe.scienceNote)
                                .font(.system(size: 13, design: .rounded))
                                .foregroundColor(Color.ouraGray)
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.darkGreen.opacity(0.05))
                        )
                    }

                    // Ingredients
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.deepForest)

                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack(spacing: 10) {
                                Circle()
                                    .fill(Color.darkGreen)
                                    .frame(width: 6, height: 6)
                                Text(ingredient)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundColor(Color.deepForest)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.ouraWhite)
                    )

                    // Steps
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Steps")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.deepForest)

                        ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(width: 26, height: 26)
                                    .background(Circle().fill(Color.darkGreen))

                                Text(step)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundColor(Color.deepForest)
                                    .padding(.top, 3)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.ouraWhite)
                    )

                    // Log button
                    Button {
                        logMeal()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: logged ? "checkmark.circle.fill" : "plus")
                                .font(.system(size: 18, weight: .bold))
                            Text(logged ? "Logged!" : "Log This Meal")
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(logged ? Color.darkGreen : .white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(logged ? Color.darkGreen.opacity(0.1) : Color.darkGreen)
                        )
                    }
                    .disabled(logged)

                    Spacer(minLength: 20)
                }
                .padding(20)
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func logMeal() {
        HapticManager.shared.notification(.success)
        let entry = IntakeEntry(
            name: recipe.name,
            calories: recipe.calories,
            probiotics: recipe.probiotics,
            fiber: recipe.fiber,
            carbs: 0,
            entryType: "food"
        )
        dataManager.addIntake(entry)
        withAnimation { logged = true }
    }
}

private struct StatPill: View {
    let label: String
    let color: Color

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundColor(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule().fill(color.opacity(0.1))
            )
    }
}
