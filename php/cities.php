<?php

include "pdo.php";
if(isset($_POST["site_type"])){
  $selected_city_name = $_POST["site_type"];
} else {
  $selected_city_name = "";
}

echo "<html><body>";
echo "<form action='cities.php' method='post'>";
echo "<select name='site_type'>";

$result = $pdo->query("SELECT cityName FROM cities");

while ($row = $result->fetch()) {
  $type = $row["cityName"];
  if ($type == $selected_city_name) {
    $option = "<option selected>";
  } else {
    $option = "<option>";
  }
  echo $option . $type . "</option>";
}

echo "</select>";
echo "<input type='submit' value='Submit'>";
echo "</form>";

if ($selected_city_name) {
  echo "<table border = 1>";
  echo "<tr><th align='left'>site name</th><th align='left'>average rating</th></tr>";

  $stmt = $pdo->prepare("SELECT siteName, ROUND(AVG(rating), 1) AS averageRating FROM cities, sites, uservisits 
  WHERE uservisits.siteID = sites.siteID AND sites.cityID = cities.cityID AND cityName = ? GROUP BY siteName");
  $stmt->execute([$selected_city_name]);

  while ($row = $stmt->fetch()) {
    echo "<tr><td>" . $row["siteName"] . "</td><td>" . $row["averageRating"] . "</td></tr>";
  }
}

echo "</table>";
echo "</body></html>";

?>