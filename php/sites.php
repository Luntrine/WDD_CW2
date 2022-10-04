<?php

include "pdo.php";

if(isset($_POST["site_type"])){
  $selected_site_type = $_POST["site_type"];
} else {
  $selected_site_type = "";
}
echo "<html><body>";
echo "<form action='sites.php' method='post'>";
echo "<select name='site_type'>";

$result = $pdo->query("SELECT DISTINCT category FROM sites ORDER BY category");

while ($row = $result->fetch()) {
  $type = $row["category"];
  if ($type == $selected_site_type) {
    $option = "<option selected>";
  } else {
    $option = "<option>";
  }
  echo $option . $type . "</option>";
}

echo "</select>";
echo "<input type='submit' value='Submit'>";
echo "</form>";

if ($selected_site_type) {
  echo "<table border = 1>";
  echo "<tr><th align='left'>Site Name</th><th align='left'>City</th><th align='left'>country</th><th align='left'>need a visa?</th></tr>";

  $stmt = $pdo->prepare("SELECT siteName, cityName, countryName, visaRequiredFromUK 
  FROM sites, cities, countries WHERE sites.cityID = cities.cityID AND 
  countries.countryID = cities.countryID AND category = ?");
  $stmt->execute([$selected_site_type]);

  while ($row = $stmt->fetch()) {
    echo "<tr><td>" . $row["siteName"] . "</td><td>" . $row["cityName"] . "</td><td>" . $row["countryName"] . "</td><td>" . $row["visaRequiredFromUK"] . "</td></tr>";
  }
}

echo "</table>";
echo "</body></html>";

?>