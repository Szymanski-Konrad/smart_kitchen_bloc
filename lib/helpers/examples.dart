import 'package:smart_kitchen/models/models.dart';

List<Recipe> exampleRecipes() {
  List<Recipe> recipes = List<Recipe>();
  List<Ingredient> ingredients = [];
  List<RecipeStep> steps = [];

  ingredients.add(Ingredient(name: 'twaróg', unit: 'g', amount: 250));
  ingredients.add(Ingredient(name: 'jajka', unit: 'sztuki', amount: 3));
  ingredients.add(Ingredient(name: 'cukier wanilinowy', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'jabłko', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'mąka', unit: 'łyżki', amount: 3));
  ingredients.add(Ingredient(name: 'cynamon', unit: 'łyżeczka', amount: 0.5));
  steps.add(RecipeStep.withContent(content: 'Do miski włożyć twaróg, dodać żółtka (białka zachować) oraz cukier wanilinowy, następnie rozgnieść praską. '));
  steps.add(RecipeStep.withContent(content: 'Jabłko obrać i zetrzeć na tarce o większych oczkach, dodać do twarogu i wymieszać. Następnie dodać mąkę i ponownie dokładnie wymieszać.'));
  steps.add(RecipeStep.withContent(content: 'Białka ubić na sztywną pianę z dodatkiem cukru pudru. Dodać do masy twarogowej i połączyć składniki delikatnie mieszając łyżką.'));
  steps.add(RecipeStep.withContent(content: 'Nakładać porcje ciasta (po ok. 2 łyżki) na rozgrzaną patelnię (np. teflonową, naleśnikową) i rozprowadzić je po powierzchni formując kształtnego placka. Można smażyć na suchej patelni lub z dodatkiem oleju.'));
  steps.add(RecipeStep.withContent(content: 'Zmniejszyć ogień i smażyć przez ok. 2 - 3 minuty lub aż od spodu będą delikatnie zrumienione na złoto. Przewrócić na drugą stronę i powtórzyć smażenie przez ok. 2 minuty. Posypać cukrem pudrem i cynamonem, opcjonalnie skropić syropem klonowym.'));

  Recipe recipe = Recipe(name: 'placki twarogowe z jabłkiem', category: 'Śniadanie', ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin', notes: 'blabla');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'banan', unit: 'sztuk', amount: 1));
  ingredients.add(Ingredient(name: 'płatki owsiane', unit: 'łyżki', amount: 3));
  ingredients.add(Ingredient(name: 'masło orzechowe', unit: 'łyżki', amount: 1));
  ingredients.add(Ingredient(name: 'cukier', unit: 'łyżeczki', amount: 2));
  ingredients.add(Ingredient(name: 'mleko', unit: 'szklanka', amount: 1));
  steps.add(RecipeStep.withContent(content: 'Składniki (banana, płatki owsiane błyskawiczne, masło orzechowe, cukier i mleko) zmiksować na gładki koktajl w blenderze. Podawać najlepiej od razu po przygotowaniu.'));
  recipe = Recipe(name: 'koktajl bananowy', category: 'Śniadanie', ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin', notes: 'blabla');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'boczek', unit: 'plastry', amount: 2));
  ingredients.add(Ingredient(name: 'oliwa', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'masło', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'jajka', unit: 'sztuki', amount:  2));
  ingredients.add(Ingredient(name: 'awokado', unit: 'sztuki', amount: 0.5));
  ingredients.add(Ingredient(name: 'pieczywo', unit: 'sztuki', amount: 2));
  steps.add(RecipeStep.withContent(content: 'Na patelnię włożyć pokrojony na mniejsze kawałki boczek. Skropić oliwą i smażyć przez ok. 4 minuty z każdej strony na umiarkowanym ogniu, aż się wytopi i zrumieni.'));
  steps.add(RecipeStep.withContent(content: 'Na drugiej patelni na maśle usmażyć jajecznicę, doprawić solą i pieprzem. '));
  steps.add(RecipeStep.withContent(content: 'Awokado obrać i pokroić na plasterki.'));
  steps.add(RecipeStep.withContent(content: 'Pieczywo opiec w tosterze, położyć na talerzu, wyłożyć jajecznicę przekładając awokado i kawałkami boczku.'));
  recipe = Recipe(name: 'tosty', category: 'Śniadanie', ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin', notes: 'blabla');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'ogórki', unit: 'sztuki', amount: 2));
  ingredients.add(Ingredient(name: 'rzodkiewki', unit: 'sztuki', amount: 4));
  ingredients.add(Ingredient(name: 'sałata', unit: 'liście', amount: 2));
  ingredients.add(Ingredient(name: 'szczypior', unit: 'łyżki', amount: 3));
  ingredients.add(Ingredient(name: 'koperek', unit: 'łyżki', amount: 2));
  ingredients.add(Ingredient(name: 'czosnek', unit: 'ząbek', amount: 1));
  ingredients.add(Ingredient(name: 'kefir', unit: 'ml', amount: 500));
  steps.add(RecipeStep.withContent(content: 'Warzywa umyć i osuszyć. Ogórki obrać ze skórki i zetrzeć na tarce o większych oczkach. Rzodkiewki tak samo zetrzeć. Włożyć do miski.'));
  steps.add(RecipeStep.withContent(content: 'Dodać drobo poszatkowane liście sałaty, szczypiorek, koperek oraz obrany i przeciśnięty przez praskę lub drobno starty czosnek.'));
  steps.add(RecipeStep.withContent(content: 'Dodać kefir, doprawić solą oraz pieprzem i wymieszać. Schłodzić w lodówce.'));
  recipe = Recipe(name: "chłodnik", category: "Obiad", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'udka kurczaka', unit: 'sztuki', amount: 5));
  ingredients.add(Ingredient(name: 'przyprawa do kurczaka', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'gałązki rozmarynu', unit: 'sztuki ', amount: 2));
  ingredients.add(Ingredient(name: 'czosnek', unit: 'ząbki', amount: 2));
  ingredients.add(Ingredient(name: 'oliwa', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'cytryna', unit: 'sztuki', amount: 0.5));
  ingredients.add(Ingredient(name: 'marchewki', unit: 'sztuki', amount: 2));
  ingredients.add(Ingredient(name: 'ziemniaki', unit: 'sztuki', amount: 4));
  ingredients.add(Ingredient(name: 'por', unit: 'sztuki', amount: 1));
  ingredients.add(Ingredient(name: 'masło', unit: 'g', amount: 25));
  steps.add(RecipeStep.withContent(content: 'Udka doprawić solą, pieprzem, natrzeć przeciśniętym przez praskę czosnkiem oraz przyprawą (pamiętając o doprawieniu mięsa również pod skórką).'));
  steps.add(RecipeStep.withContent(content: 'Wysmarować oliwą i odłożyć do zamarynowania jeśli mamy czas. Ułożyć z zachowaniem odstępów w większej formie lub blaszce do pieczenia.'));
  steps.add(RecipeStep.withContent(content: 'Na wierzchu każdego udka położyć po pół plasterka cytryny, obłożyć listkami rozmarynu.'));
  steps.add(RecipeStep.withContent(content: 'Obrać ziemniaki i pokroić w kostkę. Marchewkę obrać i pokroić na plastry. Odciąć zielone liście pora. Białą i jasnozieloną część pokroić na plastry.'));
  steps.add(RecipeStep.withContent(content: 'Warzywa ułożyć wkoło udek, doprawić je solą i pieprzem. Mięso i warzywa posmarować roztopionym masłem.'));
  steps.add(RecipeStep.withContent(content: 'Wstawić do piekarnika nagrzanego do 200 stopni C i piec przez ok. 50 minut.'));
  recipe = Recipe(name: "Pieczone udka z ziemniakami, porem i marchewką", category: "Obiad", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'schab bez kości', unit: 'g', amount: 700));
  ingredients.add(Ingredient(name: 'olej', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'bulion', unit: 'ml', amount: 500));
  ingredients.add(Ingredient(name: 'ząbek czosnku', unit:'sztuk', amount: 1));
  ingredients.add(Ingredient(name: 'marchewki', unit: 'sztuki', amount: 0.5));
  ingredients.add(Ingredient(name: 'cebula', unit: 'sztuki', amount: 0.25));
  ingredients.add(Ingredient(name: 'śmietana 30%', unit: 'szklanka', amount: 0.33));
  ingredients.add(Ingredient(name: 'mąka pszenna', unit: 'łyżeczka', amount: 1.5));
  ingredients.add(Ingredient(name: 'mąka ziemniaczana', unit: 'łyżeczka', amount: 1.5));
  ingredients.add(Ingredient(name: 'koperek', unit: 'łyżki', amount: 2));
  steps.add(RecipeStep.withContent(content: 'Mięso pokroić na grube plastry i rozbić (najlepiej poprosić o wystekowanie jeszcze w sklepie w specjalnej maszynie). Rozgrzać dużą patelnię, rozprowadzić po niej olej, włożyć mięso i na dużym ogniu obsmażać po 5 minut z każdej strony.'));
  steps.add(RecipeStep.withContent(content: 'W międzyczasie zagotować bulion w garnku. Włożyć w niego podsmażone mięso (można ułożyć jeden plaster na drugim), doprawić solą (ok. 1/2 łyżeczki) i pieprzem.'));
  steps.add(RecipeStep.withContent(content: 'Po zagotowaniu przykryć garnek, zmniejszyć ogień i gotować przez ok. 1 godzinę lub nieco krócej, do kruchości mięsa. W połowie czasu dodać obrany ząbek czosnku, obraną i startą marchewkę oraz pokrojoną w kosteczkę cebulę.'));
  steps.add(RecipeStep.withContent(content: 'Do ugotowanego mięsa dodać śmietankę oraz (bezpośrednio przez sitko) mąkę pszennę i ziemniaczaną. Wymieszać delikatnie i zagotować. Dodać posiekany koperek i jeszcze pogotować przez ok. 1 minutę.'));
  recipe = Recipe(name: "Schab w sosie koperkowym", category: "Obiad", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'makaron', unit: 'g', amount: 250));
  ingredients.add(Ingredient(name: 'oliwa', unit: 'łyżka', amount: 1));
  ingredients.add(Ingredient(name: 'boczek wędzony', unit: 'g', amount: 200));
  ingredients.add(Ingredient(name: 'por', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'cukinia', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'ząbek czosnku', unit: 'sztuki', amount: 2));
  ingredients.add(Ingredient(name: 'natka pietruszki', unit: 'łyżki', amount: 2));
  ingredients.add(Ingredient(name: 'śmietana 30%', unit: 'ml', amount: 250));
  ingredients.add(Ingredient(name: 'tary ser', unit: 'łyżki', amount: 3));
  steps.add(RecipeStep.withContent(content: 'Makaron ugotować al dente w osolonej wodzie, odcedzić, włożyć z powrotem do garnka. Piekarnik nagrzać do 190 stopni C (jeśli danie będziemy dodatkowo zapiekać).'));
  steps.add(RecipeStep.withContent(content: 'Na dużej patelni na oliwie zeszklić pokrojonego pora. Dodać drobno starty czosnek a następnie boczek pokrojony w kostkę.'));
  steps.add(RecipeStep.withContent(content: 'Smażyć co chwilę mieszając przez ok. 5 minut, następnie dodać pokrojoną w kosteczkę cukinię i smażyć przez kolejne 5 minut.'));
  steps.add(RecipeStep.withContent(content: 'Dodać posiekaną natkę pietruszki oraz śmietankę. Zagotować, doprawić solą oraz pieprzem. Dodać makaron i wymieszać.'));
  steps.add(RecipeStep.withContent(content: 'Opcjonalnie danie można dodatkowo zapiec w piekarniku. W tym celu należy je przełożyć do naczynia żaroodpornego lub blaszki. Posypać tartym serem i zapiekać bez przykrycia przez ok. 10 minut.'));
  steps.add(RecipeStep.withContent(content: 'Jeśli dania nie zapiekamy, możemy posypać je serem już po nałożeniu na talerze.'));
  recipe = Recipe(name: "Makaron zapiekany z cukinią i boczkiem", category: "Kolacja", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'kiełbasa', unit: 'g', amount: 300));
  ingredients.add(Ingredient(name: 'wędzony boczek', unit: 'g', amount: 200));
  ingredients.add(Ingredient(name: 'oliwa', unit: 'łyżki', amount: 2));
  ingredients.add(Ingredient(name: 'cebula', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'marchewki', unit: 'sztuki', amount: 2));
  ingredients.add(Ingredient(name: 'papryka czerwona', unit: 'sztuki', amount: 1));
  ingredients.add(Ingredient(name: 'bulion', unit: 'ml', amount: 500));
  ingredients.add(Ingredient(name: 'biała fasolka', unit: 'puszka', amount: 1));
  ingredients.add(Ingredient(name: 'pomidory rozdrobnione', unit: 'puszka', amount: 1));
  ingredients.add(Ingredient(name: 'natka pietruszki', unit: 'szczypta', amount: 1));
  steps.add(RecipeStep.withContent(content: 'Kiełbasę obrać jeśli jest taka konieczność, następnie pokroić w kostkę. Boczek również pokroić w kostkę.'));
  steps.add(RecipeStep.withContent(content: 'Do szerokiego garnka, najlepiej z grubym dnem, wlać 1 łyżkę oliwy lub oleju. Włożyć boczek i co chwilę mieszając podsmażać na małym ogniu przez ok. 7 minut, aż się wytopi.'));
  steps.add(RecipeStep.withContent(content: 'Dodać pokrojoną kiełbasę i smażyć razem przez ok. 5 minut, aż składniki zaczną się rumienić. Dodać pokrojoną w kosteczkę cebulę i co chwilę mieszając smażyć przez ok. 5 minut.'));
  steps.add(RecipeStep.withContent(content: 'Dodać 1 łyżkę oliwy lub oleju, obraną i pokrojoną na plasterki marchewkę oraz pokrojoną w kostkę paprykę i smażyć przez ok. 3 minuty. Pod koniec dodać przyprawy.'));
  steps.add(RecipeStep.withContent(content: 'Wlać gorący bulion i zagotować. Gotować przez 5 minut, następnie dodać zawartość puszki z fasolką (fasola z zalewą) i gotować przez kolejne 5 minut.'));
  steps.add(RecipeStep.withContent(content: 'Dodać rozdrobnione pomidory z puszki (jeśli są w całości należy je zmiksować razem z zalewą) i gotować przez ok. 5 - 10 minut.'));
  steps.add(RecipeStep.withContent(content: 'Sprawdzić doprawienie solą, podawać z natką pietruszki i pieczywem.'));
  recipe = Recipe(name: "Chłopski garnek", category: "Kolacja", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  ingredients = []; steps = [];
  ingredients.add(Ingredient(name: 'filety z kurczaka', unit: 'sztuki', amount: 2));
  ingredients.add(Ingredient(name: 'ząbek czosnku', unit: 'sztuki', amount: 1));
  ingredients.add(Ingredient(name: 'mąka ziemniaczana', unit: 'łyżeczki', amount: 2));
  ingredients.add(Ingredient(name: 'oliwa', unit: 'łyżki', amount: 2));
  ingredients.add(Ingredient(name: 'por', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'kukurydza', unit: 'puszka', amount: 1));
  ingredients.add(Ingredient(name: 'ananas', unit: 'puszka', amount: 1));
  ingredients.add(Ingredient(name: 'czerwona fasolka', unit: 'puszka', amount: 1));
  ingredients.add(Ingredient(name: 'ser żółty', unit: 'g', amount: 150));
  ingredients.add(Ingredient(name: 'sałata', unit: 'sztuka', amount: 1));
  ingredients.add(Ingredient(name: 'majonez', unit: 'łyżki', amount: 4));
  ingredients.add(Ingredient(name: 'jogurt', unit: 'łyżka', amount: 2));
  steps.add(RecipeStep.withContent(content: 'Filety kurczaka pokroić w kostkę, wymieszać z przeciśniętym przez praskę czosnkiem, doprawić solą, pieprzem oraz wszystkimi przyprawami, na koniec obtoczyć w mące ziemniaczanej.'));
  steps.add(RecipeStep.withContent(content: 'Rozgrzać tłuszcz na patelni, włożyć kurczaka i na większym ogniu obsmażyć z każdej strony na złoty kolor.'));
  steps.add(RecipeStep.withContent(content: 'Obciąć zielone liście pora. Białą i jasnozieloną część przekroić wzdłuż na pół i dokładnie opłukać. Pokroić na paseczki, włożyć do sitka i przelać wrzącą wodą z czajnika. Odcedzić.'));
  steps.add(RecipeStep.withContent(content: 'Fasolkę wyłożyć na sitko i przepłukać bieżącą wodą, odcedzić. Odcedzić i pokroić ananasa oraz odcedzić kukurydzę. Ser żółty zetrzeć na tarce o większych oczkach.'));
  steps.add(RecipeStep.withContent(content: 'Układać składniki warstwowo w salaterce, pamiętając aby posmarować jedną warstwę majonezem a na nim rozsmarować jogurt lub śmietanę. Na wierzch dać posiekane liście sałaty.'));
  recipe = Recipe(name: "Sałatka z kurczakiem", category: "Kolacja", ingredients: ingredients, steps: steps, rating: 0.0, ratingCount: 0, user: 'Admin');
  recipes.add(recipe);

  return recipes;
}