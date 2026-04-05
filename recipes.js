// ─── IMAGE MANIFEST (actual files in each category folder) ───
var recipeImageManifest = {
  fermented: [
    "fresh_sauerkraut_salad_bowl_top-down_view_vibran_a38e99ce-88ac-4e4b-b6a3-99962e468c46_2.png",
    "pickeled veggie_bowl_with_pickled_vegetable_8ffb4ce2-ef94-4feb-a915-0bfd7a59285f_1.png",
    "slippery_creamy_porridge_bowl_with_soft_lighting_calming__2e6ea53a-4455-4aa5-96b2-12222fc9a98e_3.png",
    "kefir_berry_smoothie_with_subtle_green_accent_a578f8ce-c5f6-46d7-8e41-7a3a2c1f8438_0.png",
    "kimchi_fried_rice_in_white_bowl_slightly_red-ora_8bc7dbb4-f05c-4792-8c2e-943ac5197b8d_3.png",
    "miso_soup_in_ceramic_bowl_light_broth_with_tofu__acd77df0-351e-41ce-857b-5b3e28b03a69_1.png",
    "tempeh_stir_fry_in_bowl_golden_browned_tempeh_cu_76c3b272-f301-4836-a217-07b81773f5dc_2.png",
    "yogurt_parfait_in_clear_glass_jar_visible_layers_303eb85b-4d27-41f4-b4da-d506325a2123_0.png",
    "kombucha_arugula_salad_with_tomatoes_and_walnuts_vinaigre_3d87c281-e821-4853-9b78-57a03d23ca6a_1.png"
  ],
  prebiotic: [
    "overnight_oats_with_banana_chia_seeds_and_yogurt_bf4dc5aa-a4de-43e0-876f-e872614b1a55_2.png",
    "garlic_roasted_asparagus_vibrant_green_tones_glo_697db761-d620-425c-99cb-df5b53aa1ea3_3.png",
    "leek_potato_soup_soft_shadows_neu_e2588ea0-6d89-4cde-93ae-6ebdafb6e673_0.png",
    "jerusalem_roasted_sunchoke_chips_clean_plate_soft__198a9c2a-cb28-4acc-a78a-a41897e73107_1.png",
    "chicory_latte_with_subtle_green_undertones_oat_m_d989bb5f-b560-4d5d-971f-670334061f01_1.png",
    "green_banana_smoothie_vibrant_green_smoothie_in__d12780c1-f616-498e-9b0d-2bb57d292e76_1.png",
    "onion_lentil_dal_in_a_ceramic_bowl_visible__f75a6193-bdf2-4e21-93b6-7c0bb9529ae9_2.png",
    "dandelion_green_salad_with_wild_jagged_leaves_sl_70b4a8b6-e79f-4efc-be11-98a7deeceb4f_0.png"
  ],
  gut_healing: [
    "turmeric_golden_milk_latte_in_ceramic_mug_soft_sh_29b600a2-aca8-41c0-992f-1ae8e3cc4bcb_3.png",
    "ginger_lemon_tea_hot_herbal_tea_in_ceramic_mug_l_cfae017e-4d09-4208-9a7a-201624bc6e7d_3.png",
    "marshmallow_root_tea_in_ceramic_mug_pale_golden_liquid_whi_f9d80ffa-bcec-423c-b110-a41ae91e546a_2.png",
    "aloe_vera_juice_drink_in_clear_glass_visible_alo_8559549d-4452-473b-8d64-f7c65e515aa2_2.png",
    "bone_broth_ramen_in_ceramic_bowl_rich_clear_brot_397190e4-6ae9-4c25-b7f6-3654ef6d32d7_1.png",
    "slippery_elm_porridge_with_smooth_texture_and__01ebfb06-1906-49e0-b80c-ab6dd760a727_2.png",
    "collagen_berry_smoothie_in_glass_with_strawberries_and_bl_52f405af-68c8-496c-8140-20d7613dfcc1_1.png"
  ],
  brain_foods: [
    "salmon_avocado_bowl_slight_angle_white_marble_co_10d0539d-1385-47f3-8f94-b6b207bc2f82_2.png",
    "blueberry_walnut_oatmeal_close-up_with_blueberries_and_wal_1bac9c8e-81bb-4e7b-8a5f-bd69e23d9ab8_2.png",
    "dark_chocolate_chia_pudding_in_glass_jar_thick_creamy_25d21087-3f7f-4115-94d0-7c32e2f0b879_1.png",
    "sardine_toast_open-faced_sourdough_toast_with_sa_06ea563b-05b5-4c87-852f-75fcbc6832eb_0.png",
    "lions_mane_mushroom_stir_fry_with_lions_mane_simple_40481b86-499d-4611-9d0f-41fdfb65f514_0.png",
    "brazil_nut_smoothie_creamy_beige_smoothie_in_gla_fcf432e1-389d-4c0a-b51f-ad86f4aa38fc_2.png",
    "matcha_avocado_pudding_with_pistachios_and_cocon_9140d50d-81f3-47a1-a902-c0d38d8c40b3_0.png"
  ]
};

// Map recipe data category keys to image folder names
var categoryFolderMap = {
  fermented: 'fermented',
  prebiotic: 'prebiotic',
  healing: 'gut_healing',
  brain: 'brain_foods'
};

// ─── IMAGE RESOLUTION ───
function normalizeForMatch(str) {
  return str
    .toLowerCase()
    .replace(/['']/g, '')          // remove curly apostrophes
    .replace(/[^a-z0-9]+/g, '_')   // replace non-alphanumeric with underscore
    .replace(/^_|_$/g, '');        // trim leading/trailing underscores
}

function resolveRecipeImage(recipeName, catId) {
  var folder = categoryFolderMap[catId];
  var files = recipeImageManifest[folder];
  if (!files || files.length === 0) return null;

  var nameNorm = normalizeForMatch(recipeName);
  // Generate keyword tokens from recipe name (e.g. "Kefir Berry Smoothie" → ["kefir","berry","smoothie"])
  var tokens = nameNorm.split('_').filter(function(t) { return t.length > 2; });

  var bestFile = null;
  var bestScore = 0;

  files.forEach(function(filename) {
    // Normalize filename: strip hash suffix and extension for matching
    var fileNorm = normalizeForMatch(filename.replace(/\.[^.]+$/, ''));

    // Strategy 1: filename starts with the normalized recipe name
    if (fileNorm.indexOf(nameNorm) === 0) {
      var score = nameNorm.length + 100; // high priority for prefix match
      if (score > bestScore) { bestScore = score; bestFile = filename; }
      return;
    }

    // Strategy 2: filename contains the full normalized name
    if (fileNorm.indexOf(nameNorm) !== -1) {
      var score2 = nameNorm.length + 50;
      if (score2 > bestScore) { bestScore = score2; bestFile = filename; }
      return;
    }

    // Strategy 3: count how many keyword tokens appear in the filename
    var matched = 0;
    tokens.forEach(function(tok) {
      if (fileNorm.indexOf(tok) !== -1) matched++;
    });
    var tokenScore = (tokens.length > 0) ? (matched / tokens.length) : 0;
    if (tokenScore >= 0.5) { // at least half the tokens match
      var score3 = matched * 10;
      if (score3 > bestScore) { bestScore = score3; bestFile = filename; }
    }
  });

  if (bestFile) {
    return 'recipes/' + folder + '/' + bestFile;
  }
  return null;
}

function resolveAllRecipeImages() {
  categoryOrder.forEach(function(catId) {
    var recipes = recipeData[catId];
    if (!recipes) return;
    recipes.forEach(function(r) {
      var resolved = resolveRecipeImage(r.name, catId);
      if (resolved) {
        r.image = resolved;
      } else {
        r.image = '';
        console.warn('[recipes] No image found for "' + r.name + '" in category "' + catId + '" (folder: ' + categoryFolderMap[catId] + ')');
      }
    });
  });
}

// ─── RECIPE DATA (matches RecipesView.swift exactly) ───
var recipeData = {
  fermented: [
    {
      name: "Kefir Berry Smoothie",
      gutBenefit: "+2g probiotics",
      prepTime: "5 min",
      probiotics: 2.0, fiber: 2.0, calories: 180,
      icon: "\u2615",
      ingredients: ["1 cup kefir", "1/2 cup mixed berries", "1 tbsp honey", "1/2 banana"],
      steps: ["Add kefir and berries to blender", "Add honey and banana", "Blend until smooth", "Pour and enjoy immediately"],
      scienceNote: "Kefir contains 30+ strains of bacteria and yeast, making it one of the most diverse probiotic foods available."
    },
    {
      name: "Kimchi Fried Rice",
      gutBenefit: "+3g probiotics",
      prepTime: "15 min",
      probiotics: 3.0, fiber: 2.0, calories: 320,
      icon: "\uD83D\uDD25",
      ingredients: ["2 cups cooked rice", "1 cup kimchi (chopped)", "2 eggs", "1 tbsp sesame oil", "2 green onions", "1 tbsp soy sauce"],
      steps: ["Heat sesame oil in a large pan", "Add chopped kimchi and stir-fry 3 min", "Add rice and soy sauce, toss to combine", "Push rice aside, scramble eggs in pan", "Mix together and top with green onions"],
      scienceNote: "Kimchi\u2019s Lactobacillus strains survive cooking and support GABA production in the gut."
    },
    {
      name: "Miso Soup",
      gutBenefit: "+1g probiotics",
      prepTime: "10 min",
      probiotics: 1.0, fiber: 1.0, calories: 85,
      icon: "\uD83C\uDF75",
      ingredients: ["2 tbsp white miso paste", "3 cups water", "1/2 block soft tofu (cubed)", "2 green onions (sliced)", "1 sheet nori (torn)"],
      steps: ["Bring water to a gentle simmer", "Dissolve miso paste in a small amount of warm water", "Add tofu cubes to the pot", "Stir in miso mixture (don\u2019t boil)", "Top with green onions and nori"],
      scienceNote: "Miso\u2019s Aspergillus oryzae produces enzymes that aid digestion and nutrient absorption."
    },
    {
      name: "Sauerkraut Salad",
      gutBenefit: "+2g probiotics",
      prepTime: "5 min",
      probiotics: 2.0, fiber: 3.0, calories: 120,
      icon: "\uD83C\uDF3F",
      ingredients: ["1 cup raw sauerkraut", "2 cups mixed greens", "1/2 avocado (sliced)", "1 tbsp olive oil", "1 tbsp apple cider vinegar", "Salt and pepper"],
      steps: ["Toss mixed greens on a plate", "Top with sauerkraut and avocado slices", "Drizzle olive oil and apple cider vinegar", "Season with salt and pepper"],
      scienceNote: "Raw sauerkraut contains Lactobacillus plantarum, which produces serotonin precursors in the gut."
    },
    {
      name: "Tempeh Stir Fry",
      gutBenefit: "+4g probiotics",
      prepTime: "20 min",
      probiotics: 4.0, fiber: 3.0, calories: 380,
      icon: "\uD83D\uDD25",
      ingredients: ["200g tempeh (cubed)", "1 cup broccoli florets", "1 red bell pepper (sliced)", "2 tbsp soy sauce", "1 tbsp sesame oil", "1 tsp ginger (grated)", "Brown rice to serve"],
      steps: ["Cube tempeh and pan-fry in sesame oil until golden", "Add ginger and stir 30 seconds", "Add broccoli and bell pepper, stir-fry 4 min", "Add soy sauce and toss to coat", "Serve over brown rice"],
      scienceNote: "Tempeh fermentation creates bioactive peptides that support gut barrier integrity."
    },
    {
      name: "Yogurt Parfait",
      gutBenefit: "+3g probiotics",
      prepTime: "5 min",
      probiotics: 3.0, fiber: 3.0, calories: 220,
      icon: "\u2615",
      ingredients: ["1 cup Greek yogurt", "1/4 cup granola", "1/2 cup mixed berries", "1 tbsp honey", "1 tbsp chia seeds"],
      steps: ["Layer yogurt in a glass", "Add granola and berries", "Drizzle with honey", "Top with chia seeds"],
      scienceNote: "Greek yogurt\u2019s Lactobacillus and Streptococcus strains directly support serotonin synthesis."
    },
    {
      name: "Kombucha Vinaigrette Salad",
      gutBenefit: "+1g probiotics",
      prepTime: "10 min",
      probiotics: 1.0, fiber: 4.0, calories: 150,
      icon: "\uD83C\uDF3F",
      ingredients: ["3 cups arugula", "1/4 cup kombucha", "2 tbsp olive oil", "1 tbsp Dijon mustard", "1/2 cup cherry tomatoes", "1/4 cup walnuts"],
      steps: ["Whisk kombucha, olive oil, and mustard for dressing", "Toss arugula with cherry tomatoes", "Add walnuts", "Drizzle dressing and toss gently"],
      scienceNote: "Kombucha\u2019s organic acids create an acidic environment that supports beneficial gut bacteria."
    },
    {
      name: "Pickled Veggie Bowl",
      gutBenefit: "+2g probiotics",
      prepTime: "15 min",
      probiotics: 2.0, fiber: 5.0, calories: 200,
      icon: "\uD83C\uDF3F",
      ingredients: ["1 cup brown rice", "1/2 cup pickled carrots", "1/2 cup pickled radish", "1/4 cup pickled ginger", "1 avocado (sliced)", "Sesame seeds", "Soy sauce"],
      steps: ["Cook brown rice and let cool slightly", "Arrange pickled vegetables on top", "Add sliced avocado", "Sprinkle sesame seeds and drizzle soy sauce"],
      scienceNote: "Naturally fermented pickled vegetables contain diverse Lactobacillus strains that colonize the gut."
    }
  ],

  prebiotic: [
    {
      name: "Overnight Oats with Banana",
      gutBenefit: "+5g fiber",
      prepTime: "5 min",
      probiotics: 0, fiber: 5.0, calories: 280,
      icon: "\uD83C\uDF19",
      ingredients: ["1/2 cup rolled oats", "1/2 cup milk", "1/4 cup yogurt", "1 banana (sliced)", "1 tbsp chia seeds", "1 tbsp honey"],
      steps: ["Mix oats, milk, and yogurt in a jar", "Add chia seeds and honey", "Top with banana slices", "Refrigerate overnight", "Eat cold in the morning"],
      scienceNote: "Oats contain beta-glucan, a prebiotic fiber that feeds Bifidobacteria and boosts short-chain fatty acid production."
    },
    {
      name: "Garlic Roasted Asparagus",
      gutBenefit: "+4g fiber",
      prepTime: "20 min",
      probiotics: 0, fiber: 4.0, calories: 95,
      icon: "\uD83C\uDF3F",
      ingredients: ["1 bunch asparagus", "4 cloves garlic (minced)", "2 tbsp olive oil", "Salt and pepper", "Lemon zest"],
      steps: ["Preheat oven to 400\u00b0F", "Trim asparagus and toss with oil and garlic", "Spread on baking sheet", "Roast 15 minutes until tender", "Finish with lemon zest"],
      scienceNote: "Asparagus is rich in inulin, a prebiotic that specifically feeds Bifidobacteria linked to mood regulation."
    },
    {
      name: "Leek and Potato Soup",
      gutBenefit: "+6g fiber",
      prepTime: "30 min",
      probiotics: 0, fiber: 6.0, calories: 210,
      icon: "\uD83C\uDF75",
      ingredients: ["3 leeks (sliced)", "2 potatoes (cubed)", "4 cups vegetable broth", "1 tbsp butter", "1/4 cup cream", "Salt, pepper, chives"],
      steps: ["Melt butter and cook leeks until soft", "Add potatoes and broth", "Simmer 20 minutes until tender", "Blend until smooth", "Stir in cream, garnish with chives"],
      scienceNote: "Leeks contain fructo-oligosaccharides, prebiotics that increase Lactobacillus populations in the gut."
    },
    {
      name: "Jerusalem Artichoke Chips",
      gutBenefit: "+8g fiber",
      prepTime: "25 min",
      probiotics: 0, fiber: 8.0, calories: 180,
      icon: "\uD83C\uDF3F",
      ingredients: ["4 Jerusalem artichokes", "2 tbsp olive oil", "1 tsp sea salt", "1/2 tsp rosemary"],
      steps: ["Preheat oven to 375\u00b0F", "Slice artichokes thinly with a mandoline", "Toss with olive oil, salt, rosemary", "Spread on parchment-lined baking sheet", "Bake 20 min until crispy"],
      scienceNote: "Jerusalem artichokes have the highest inulin content of any vegetable \u2014 up to 76% of dry weight."
    },
    {
      name: "Chicory Root Latte",
      gutBenefit: "+3g fiber",
      prepTime: "5 min",
      probiotics: 0, fiber: 3.0, calories: 45,
      icon: "\u2615",
      ingredients: ["2 tbsp roasted chicory root granules", "1 cup hot water", "1/4 cup oat milk", "1/2 tsp cinnamon", "1 tsp honey (optional)"],
      steps: ["Steep chicory root in hot water 3 minutes", "Heat oat milk and froth", "Pour chicory into mug", "Top with frothed milk and cinnamon"],
      scienceNote: "Chicory root is 65% inulin by weight, making it the most concentrated prebiotic food source."
    },
    {
      name: "Dandelion Green Salad",
      gutBenefit: "+4g fiber",
      prepTime: "10 min",
      probiotics: 0, fiber: 4.0, calories: 85,
      icon: "\uD83C\uDF3F",
      ingredients: ["2 cups dandelion greens", "1/2 cup strawberries (sliced)", "2 tbsp goat cheese", "1 tbsp balsamic vinegar", "1 tbsp olive oil", "1 tbsp pumpkin seeds"],
      steps: ["Wash and dry dandelion greens", "Arrange on plate with strawberries", "Crumble goat cheese on top", "Whisk balsamic and olive oil, drizzle", "Top with pumpkin seeds"],
      scienceNote: "Dandelion greens contain inulin and promote bile production, supporting fat digestion and gut motility."
    },
    {
      name: "Onion and Lentil Dal",
      gutBenefit: "+9g fiber",
      prepTime: "35 min",
      probiotics: 0, fiber: 9.0, calories: 290,
      icon: "\uD83D\uDD25",
      ingredients: ["1 cup red lentils", "2 onions (diced)", "3 cloves garlic", "1 tsp turmeric", "1 tsp cumin", "1 can coconut milk", "Salt, cilantro"],
      steps: ["Cook lentils in water until soft", "In a separate pan, fry onions and garlic until golden", "Add turmeric and cumin to onions", "Combine lentils and onion mixture", "Stir in coconut milk, simmer 10 min", "Garnish with cilantro"],
      scienceNote: "Onions are rich in fructo-oligosaccharides and lentils provide resistant starch \u2014 both feed beneficial gut bacteria."
    },
    {
      name: "Green Banana Smoothie",
      gutBenefit: "+6g fiber",
      prepTime: "5 min",
      probiotics: 0, fiber: 6.0, calories: 195,
      icon: "\u2615",
      ingredients: ["1 green (unripe) banana", "1 cup spinach", "1/2 cup almond milk", "1 tbsp almond butter", "1/2 tsp cinnamon", "Ice cubes"],
      steps: ["Add all ingredients to blender", "Blend until smooth", "Add ice for thickness", "Pour and drink immediately"],
      scienceNote: "Green bananas contain resistant starch that feeds butyrate-producing bacteria, directly supporting gut lining repair."
    }
  ],

  healing: [
    {
      name: "Bone Broth Ramen",
      gutBenefit: "+collagen",
      prepTime: "20 min",
      probiotics: 0, fiber: 2.0, calories: 310,
      icon: "\uD83C\uDF75",
      ingredients: ["2 cups bone broth", "1 pack ramen noodles", "1 soft-boiled egg", "2 green onions", "1 tbsp soy sauce", "1 tsp sesame oil", "Nori sheets"],
      steps: ["Heat bone broth until simmering", "Cook noodles according to package", "Place noodles in bowl, pour broth over", "Top with halved soft-boiled egg", "Add green onions, nori, sesame oil"],
      scienceNote: "Bone broth provides glutamine and collagen peptides that directly repair intestinal lining tight junctions."
    },
    {
      name: "Turmeric Golden Milk",
      gutBenefit: "+anti-inflammatory",
      prepTime: "5 min",
      probiotics: 0, fiber: 0, calories: 120,
      icon: "\u2615",
      ingredients: ["1 cup oat milk", "1 tsp turmeric powder", "1/2 tsp cinnamon", "1/4 tsp black pepper", "1 tsp honey", "1/2 tsp coconut oil"],
      steps: ["Heat oat milk in a saucepan", "Whisk in turmeric, cinnamon, and pepper", "Add coconut oil and honey", "Simmer 3 minutes (don\u2019t boil)", "Strain and serve warm"],
      scienceNote: "Curcumin in turmeric reduces gut inflammation. Black pepper increases absorption by 2000%."
    },
    {
      name: "Aloe Vera Juice Blend",
      gutBenefit: "+gut lining",
      prepTime: "5 min",
      probiotics: 0, fiber: 0, calories: 65,
      icon: "\uD83D\uDCA7",
      ingredients: ["2 tbsp aloe vera juice", "1 cup coconut water", "1/2 cucumber (peeled)", "Juice of 1 lime", "Fresh mint leaves"],
      steps: ["Blend cucumber with coconut water", "Add aloe vera juice and lime", "Strain if desired", "Garnish with mint", "Serve cold"],
      scienceNote: "Aloe vera\u2019s acemannan polysaccharides coat and soothe the gut lining while reducing intestinal inflammation."
    },
    {
      name: "Slippery Elm Porridge",
      gutBenefit: "+gut lining",
      prepTime: "10 min",
      probiotics: 0, fiber: 4.0, calories: 180,
      icon: "\uD83C\uDF75",
      ingredients: ["1/2 cup rolled oats", "1 tbsp slippery elm powder", "1 cup water", "1/2 cup almond milk", "1 tbsp maple syrup", "Cinnamon"],
      steps: ["Combine oats and water in a pot", "Bring to a simmer, stir in slippery elm", "Cook 5 minutes stirring constantly", "Add almond milk and maple syrup", "Top with cinnamon"],
      scienceNote: "Slippery elm creates a mucilage coating that protects inflamed gut tissue and promotes healing."
    },
    {
      name: "Ginger Lemon Tea",
      gutBenefit: "+digestion",
      prepTime: "5 min",
      probiotics: 0, fiber: 0, calories: 25,
      icon: "\uD83C\uDF75",
      ingredients: ["1 inch fresh ginger (sliced)", "Juice of 1/2 lemon", "2 cups hot water", "1 tsp honey"],
      steps: ["Slice ginger into thin coins", "Steep in hot water 5 minutes", "Squeeze in lemon juice", "Stir in honey", "Sip slowly"],
      scienceNote: "Ginger\u2019s gingerols accelerate gastric emptying and reduce nausea by acting on serotonin receptors in the gut."
    },
    {
      name: "Collagen Berry Smoothie",
      gutBenefit: "+collagen",
      prepTime: "5 min",
      probiotics: 0, fiber: 3.0, calories: 240,
      icon: "\u2615",
      ingredients: ["1 scoop collagen peptides", "1 cup mixed berries", "1/2 cup almond milk", "1/2 banana", "1 tbsp flaxseed"],
      steps: ["Add all ingredients to blender", "Blend until smooth", "Pour into glass", "Enjoy immediately"],
      scienceNote: "Collagen peptides provide glycine and proline, amino acids essential for rebuilding the intestinal lining."
    },
    {
      name: "Marshmallow Root Tea",
      gutBenefit: "+gut lining",
      prepTime: "10 min",
      probiotics: 0, fiber: 0, calories: 15,
      icon: "\uD83C\uDF75",
      ingredients: ["1 tbsp dried marshmallow root", "2 cups hot water", "1 tsp honey (optional)", "Lemon slice"],
      steps: ["Add marshmallow root to a teapot", "Pour hot water over and steep 10 minutes", "Strain into mug", "Add honey and lemon if desired"],
      scienceNote: "Marshmallow root\u2019s mucilage coats the GI tract, reducing inflammation and protecting against acid damage."
    }
  ],

  brain: [
    {
      name: "Salmon Avocado Bowl",
      gutBenefit: "+omega-3",
      prepTime: "15 min",
      probiotics: 0, fiber: 5.0, calories: 420,
      icon: "\uD83D\uDC1F",
      ingredients: ["1 salmon fillet", "1 avocado (sliced)", "1 cup brown rice", "1/2 cup edamame", "Soy sauce", "Sesame seeds", "Pickled ginger"],
      steps: ["Cook brown rice", "Pan-sear salmon 4 min per side", "Arrange rice in bowl", "Top with flaked salmon and avocado", "Add edamame, ginger, sesame seeds", "Drizzle soy sauce"],
      scienceNote: "Salmon\u2019s EPA and DHA omega-3s cross the blood-brain barrier and reduce neuroinflammation, improving focus and mood."
    },
    {
      name: "Blueberry Walnut Oatmeal",
      gutBenefit: "+antioxidants",
      prepTime: "10 min",
      probiotics: 0, fiber: 6.0, calories: 340,
      icon: "\uD83C\uDF75",
      ingredients: ["1/2 cup rolled oats", "1 cup water", "1/2 cup blueberries", "2 tbsp walnuts (chopped)", "1 tbsp honey", "Cinnamon"],
      steps: ["Cook oats in water until creamy", "Top with blueberries and walnuts", "Drizzle honey", "Sprinkle cinnamon"],
      scienceNote: "Blueberry anthocyanins improve memory and walnuts provide ALA omega-3s that support neurotransmitter function."
    },
    {
      name: "Dark Chocolate Chia Pudding",
      gutBenefit: "+magnesium",
      prepTime: "5 min",
      probiotics: 0, fiber: 8.0, calories: 280,
      icon: "\u2615",
      ingredients: ["3 tbsp chia seeds", "1 cup almond milk", "1 tbsp cocoa powder", "1 tbsp maple syrup", "Dark chocolate shavings"],
      steps: ["Mix chia seeds, milk, cocoa, and maple syrup", "Stir well to prevent clumping", "Refrigerate 4 hours or overnight", "Top with dark chocolate shavings"],
      scienceNote: "Dark chocolate\u2019s flavonoids increase cerebral blood flow. Chia seeds provide fiber that feeds serotonin-producing gut bacteria."
    },
    {
      name: "Sardine Toast",
      gutBenefit: "+omega-3",
      prepTime: "5 min",
      probiotics: 0, fiber: 2.0, calories: 290,
      icon: "\uD83D\uDC1F",
      ingredients: ["1 can sardines in olive oil", "2 slices sourdough bread", "1/2 lemon", "1 tbsp capers", "Fresh parsley", "Red pepper flakes"],
      steps: ["Toast sourdough bread", "Arrange sardines on toast", "Squeeze lemon juice over", "Top with capers, parsley, pepper flakes"],
      scienceNote: "Sardines provide more omega-3 per serving than salmon, plus vitamin D which regulates gut immune function."
    },
    {
      name: "Lion\u2019s Mane Mushroom Stir Fry",
      gutBenefit: "+NGF",
      prepTime: "20 min",
      probiotics: 0, fiber: 3.0, calories: 195,
      icon: "\uD83C\uDF3F",
      ingredients: ["200g lion\u2019s mane mushroom", "1 tbsp butter", "2 cloves garlic", "1 tbsp soy sauce", "Fresh thyme", "Black pepper"],
      steps: ["Tear mushroom into bite-sized pieces", "Melt butter in pan over medium heat", "Add mushroom and cook 5 min until golden", "Add garlic and thyme, cook 2 min", "Finish with soy sauce and pepper"],
      scienceNote: "Lion\u2019s mane contains hericenones and erinacines that stimulate Nerve Growth Factor (NGF) production in the brain."
    },
    {
      name: "Brazil Nut Smoothie",
      gutBenefit: "+selenium",
      prepTime: "5 min",
      probiotics: 0, fiber: 3.0, calories: 310,
      icon: "\u2615",
      ingredients: ["3 Brazil nuts", "1 banana", "1 cup oat milk", "1 tbsp cacao nibs", "1 tsp maca powder", "1 tbsp honey"],
      steps: ["Add Brazil nuts and oat milk to blender", "Add banana, cacao nibs, and maca", "Blend until smooth", "Drizzle honey on top"],
      scienceNote: "Just 2 Brazil nuts provide a full day\u2019s selenium, essential for thyroid function and neurotransmitter synthesis."
    },
    {
      name: "Matcha Avocado Pudding",
      gutBenefit: "+L-theanine",
      prepTime: "10 min",
      probiotics: 0, fiber: 5.0, calories: 220,
      icon: "\u2615",
      ingredients: ["1 ripe avocado", "1 tsp matcha powder", "2 tbsp maple syrup", "1/4 cup coconut cream", "Pistachios for topping"],
      steps: ["Blend avocado until smooth", "Add matcha, maple syrup, and coconut cream", "Blend until creamy and uniform green", "Spoon into bowls", "Top with crushed pistachios"],
      scienceNote: "Matcha\u2019s L-theanine crosses the blood-brain barrier, promoting alpha brain waves for calm focus without drowsiness."
    }
  ]
};

// Category metadata (order matches RecipesView.swift CaseIterable)
var categoryOrder = ['fermented', 'prebiotic', 'healing', 'brain'];
var categoryMeta = {
  fermented: { label: 'Fermented', icon: '\uD83E\uDDEA', count: 8 },
  prebiotic: { label: 'Prebiotic', icon: '\uD83C\uDF3F', count: 8 },
  healing:   { label: 'Gut Healing', icon: '\uD83D\uDC9A', count: 7 },
  brain:     { label: 'Brain Foods', icon: '\uD83E\uDDE0', count: 7 }
};

// ─── RENDER RECIPE CARDS ───
function renderRecipeCards() {
  categoryOrder.forEach(function(catId) {
    var panel = document.getElementById('recipes-' + catId);
    if (!panel) return;

    var recipes = recipeData[catId];
    var html = '';

    recipes.forEach(function(r, idx) {
      html += '<div class="recipe-card" onclick="openRecipeDetail(\'' + catId + '\',' + idx + ')">';
      html += '  <div class="recipe-card-thumb">';
      if (r.image) {
        html += '    <img src="' + encodeURI(r.image) + '" alt="' + escapeHtml(r.name) + '" loading="lazy" onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'flex\'">';
        html += '    <span class="recipe-icon-fallback" style="display:none">' + r.icon + '</span>';
      } else {
        html += '    <span class="recipe-icon-fallback" style="display:flex">' + r.icon + '</span>';
      }
      html += '  </div>';
      html += '  <div class="recipe-card-body">';
      html += '    <div class="recipe-info">';
      html += '      <div class="recipe-name">' + escapeHtml(r.name) + '</div>';
      html += '      <div class="recipe-meta">';
      html += '        <span class="recipe-benefit">' + escapeHtml(r.gutBenefit) + '</span>';
      html += '        <span class="recipe-time">' + escapeHtml(r.prepTime) + '</span>';
      html += '      </div>';
      html += '    </div>';
      html += '    <span class="recipe-chevron">\u203A</span>';
      html += '  </div>';
      html += '</div>';
    });

    panel.innerHTML = html;
  });
}

// ─── RECIPE DETAIL MODAL ───
function openRecipeDetail(catId, idx) {
  var r = recipeData[catId][idx];
  if (!r) return;

  var modal = document.getElementById('recipeModal');
  var content = document.getElementById('recipeModalContent');

  var html = '';

  // Close button
  html += '<button class="recipe-modal-close" onclick="closeRecipeDetail()" aria-label="Close">\u2715</button>';

  // Image or icon header
  if (r.image) {
    html += '<img class="recipe-detail-image" src="' + encodeURI(r.image) + '" alt="' + escapeHtml(r.name) + '" onerror="this.outerHTML=\'<div class=recipe-detail-icon-header>' + r.icon + '</div>\'">';
  } else {
    html += '<div class="recipe-detail-icon-header">' + r.icon + '</div>';
  }

  html += '<div class="recipe-detail-content">';

  // Title
  html += '<h3 class="recipe-detail-title">' + escapeHtml(r.name) + '</h3>';

  // Stat pills
  html += '<div class="recipe-detail-pills">';
  html += '  <span class="recipe-pill">' + escapeHtml(r.gutBenefit) + '</span>';
  html += '  <span class="recipe-pill muted">' + escapeHtml(r.prepTime) + '</span>';
  html += '  <span class="recipe-pill muted">' + r.calories + ' cal</span>';
  html += '</div>';

  // Nutrition row
  html += '<div class="recipe-nutrition-row">';
  if (r.probiotics > 0) {
    html += '<div class="recipe-nutrition-item"><div class="recipe-nutrition-value">' + r.probiotics + 'g</div><div class="recipe-nutrition-label">Probiotics</div></div>';
  }
  if (r.fiber > 0) {
    html += '<div class="recipe-nutrition-item"><div class="recipe-nutrition-value">' + r.fiber + 'g</div><div class="recipe-nutrition-label">Fiber</div></div>';
  }
  html += '<div class="recipe-nutrition-item"><div class="recipe-nutrition-value">' + r.calories + '</div><div class="recipe-nutrition-label">Calories</div></div>';
  html += '</div>';

  // Science note
  if (r.scienceNote) {
    html += '<div class="recipe-science-note">';
    html += '  <span class="recipe-science-icon">\uD83E\uDDE0</span>';
    html += '  <span class="recipe-science-text">' + escapeHtml(r.scienceNote) + '</span>';
    html += '</div>';
  }

  // Ingredients
  html += '<div class="recipe-detail-card">';
  html += '  <div class="recipe-detail-card-title">Ingredients</div>';
  html += '  <ul class="recipe-ingredients-list">';
  r.ingredients.forEach(function(ing) {
    html += '    <li>' + escapeHtml(ing) + '</li>';
  });
  html += '  </ul>';
  html += '</div>';

  // Steps
  html += '<div class="recipe-detail-card">';
  html += '  <div class="recipe-detail-card-title">Steps</div>';
  html += '  <ol class="recipe-steps-list">';
  r.steps.forEach(function(step) {
    html += '    <li>' + escapeHtml(step) + '</li>';
  });
  html += '  </ol>';
  html += '</div>';

  html += '</div>'; // .recipe-detail-content

  content.innerHTML = html;
  modal.classList.add('open');
  document.body.style.overflow = 'hidden';
}

function closeRecipeDetail() {
  var modal = document.getElementById('recipeModal');
  modal.classList.remove('open');
  document.body.style.overflow = '';
}

function escapeHtml(str) {
  var div = document.createElement('div');
  div.textContent = str;
  return div.innerHTML;
}

// Close modal on overlay click
document.addEventListener('click', function(e) {
  var modal = document.getElementById('recipeModal');
  if (e.target === modal) closeRecipeDetail();
});

// Close modal on Escape
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') closeRecipeDetail();
});

// Initialize
document.addEventListener('DOMContentLoaded', function() {
  resolveAllRecipeImages();
  renderRecipeCards();
});
