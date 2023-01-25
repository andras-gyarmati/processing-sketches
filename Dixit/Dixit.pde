Game game;

void setup() {
  size(100, 100);
  game = new Game();
  noLoop();
}

void draw() {
  game.debug();
  game.firstRound();
}

class Player {
  ArrayList<Card> cards;
  String name;
  boolean isCurrent;
  Card selected;
  String hint;
  Card guess;
  int score;

  Player(String name) {
    this.cards = new ArrayList<Card>();
    this.name = name;
    score = 0;
  }

  void addCard(Card card) {
    cards.add(card);
  }

  void debug() {
    println(name + "'s deck:");
    for (Card c : cards) {
      c.debug();
    }
  }

  Card select() {
    selected = cards.get(floor(random(cards.size())));
    cards.remove(selected);
    return selected;
  }
}

class Card {
  String name;

  Card(String name) {
    this.name = name;
  }

  void debug() {
    println(this.name);
  }
}

class Game {
  ArrayList<Player> players;
  ArrayList<Card> deck;
  ArrayList<Card> discardDeck;
  Player current;

  Game() {
    players = new ArrayList<Player>();
    deck = new ArrayList<Card>();
    discardDeck = new ArrayList<Card>();
    initDeck();
    initPlayers();
    initGame();
  }

  void firstRound() {
    println("");
    println("First Round:");
    println("current: " + current.name);

    //ArrayList<Card> scs = new ArrayList<Card>();

    //for (Player p : players) {
    //  scs.add(p.select());
    //}

    current.hint = "HINT";

    for (Player p : players) {
      p.guess = null;
      Card c = p.select();
      println(p.name+ " selected " + p.selected.name);
    }

    println("hint: " + current.hint);

    for (Player p : players) {
      if (p.isCurrent) continue;
      do {
        p.guess = players.get(floor(random(players.size()))).selected;
        //p.guess = current.selected; //debug
      } while (p.guess == null || p.guess == p.selected);
      println(p.name + "'s guess: "  + p.guess.name);
    }

    int hitCount = 0;
    for (Player p : players) {
      if (p.guess == current.selected) {
        hitCount++;
      }
    }

    println("hits: " + hitCount);

    boolean isFailed = hitCount == 0 || hitCount == players.size() - 1;

    println("fail: " + isFailed);

    if (isFailed) {
      for (Player p : players) {
        if (p.isCurrent) continue;
        p.score += 2;
      }
    } else {
      for (Player p : players) {
        if (p.isCurrent) {
          p.score += 3;
        }
        if (p.guess == current.selected) {
          p.score += 3;

          int votedByOthersCount = 0;
          for (Player other : players) {
            if (other.guess == p.selected) {
              votedByOthersCount++;
            }
          }
          p.score += votedByOthersCount;
        }
      }
    }

    for (Player p : players) {
      println(p.name + "'s score: " + p.score);
    }
  }

  void initDeck() {
    for (int i = 0; i < 42; i++) {
      this.deck.add(new Card("card " + i));
    }
  }

  void initPlayers() {
    for (int i = 0; i < 5; i++) {
      Player p = new Player("Player " + i);
      players.add(p);
      for (int j = 0; j < 6; j++) {
        p.addCard(this.getRandomCard());
      }
    }
  }

  void initGame() {
    current = players.get(floor(random(players.size())));
    current.isCurrent = true;
  }

  Card getRandomCard() {
    Card c = deck.get(floor(random(deck.size())));
    deck.remove(c);
    return c;
  }

  void debug() {
    for (Player p : players) {
      p.debug();
    }

    println("draw deck:");
    for (Card c : deck) {
      c.debug();
    }
  }
}
