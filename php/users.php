<?php

include "pdo.php";
if(isset($_POST["site_type"])){
  $selected_user = $_POST["site_type"];
} else {
  $selected_user = "";
}

echo "<html><body>";
echo "<form action='users.php' method='post'>";
echo "<select name='site_type'>";

$result = $pdo->query("SELECT userID FROM users");

while ($row = $result->fetch()) {
  $type = $row["userID"];
  if ($type == $selected_user) {
    $option = "<option selected>";
  } else {
    $option = "<option>";
  }
  echo $option . $type . "</option>";
}

echo "</select>";
echo "<input type='submit' value='Submit'>";
echo "</form>";

if ($selected_user) {
  echo "<table border = 1>";
  echo "<tr><th align='left'>name</th><th align='left'>cities visited</th></tr>";

  $stmt = $pdo->prepare("SELECT DISTINCT name, cityName FROM users, cities, uservisits, sites
  WHERE uservisits.userID = users.userID AND uservisits.siteID = sites.siteID AND sites.cityID = cities.cityID AND users.userID = ?");
  $stmt->execute([$selected_user]);

  while ($row = $stmt->fetch()) {
    echo "<tr><td>" . $row["name"] . "</td><td>" . $row["cityName"] . "</td></tr>";
  }
}

echo "</table>";
echo "</body></html>";

?>