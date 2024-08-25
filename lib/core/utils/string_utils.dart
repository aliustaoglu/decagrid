String generateHintText(int tilesCleared) {
  switch (tilesCleared) {
    case -2:
      return "Double Trouble,\nBut in Reverse!";
    case -3:
      return "Triple Tumble!";
    case -4:
      return "Negative Quad!";
    case -5:
      return "Minus Five Strive!";
    case -6:
      return "Six Steps Back!";
    case -7:
      return "Seven Slips!";
    case -8:
      return "Eight Errors!";
    case -9:
      return "Ninth Nosedive!";
    case -10:
      return "Negative Perfect Ten!";
    case 2:
      return "Double Trouble!";
    case 3:
      return "Triple Treat!";
    case 4:
      return "Quad Power!";
    case 5:
      return "High Five!";
    case 6:
      return "Sizzling Six!";
    case 7:
      return "Lucky Seven!";
    case 8:
      return "Great Eight!";
    case 9:
      return "Divine Nine!";
    case 10:
      return "Perfect Ten!";
    case 11:
      return "One Louder!";
    case 12:
      return "Dazzling Dozen!";
    case 13:
      return "Thirteen Thunder!";
    case 14:
      return "Fantastic Fourteen!";
    case 15:
      return "Fifteen Fury!";
    case 16:
      return "Sweet Sixteen!";
    case 17:
      return "Seventeen Surge!";
    case 18:
      return "Eighteen Excellents!";
    case 19:
      return "Nineteen Nirvana!";
    case 20:
      return "Twenty Triumph!";
    default:
      return tilesCleared > 20
          ? "Tile Master Supreme!"
          : "Back to the Beginning!";
  }
}
