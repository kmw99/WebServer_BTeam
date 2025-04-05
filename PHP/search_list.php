<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "localhost";
$username = "dbuser";  // 실제 사용자명으로 변경
$password = "dbpass";  // 실제 비밀번호로 변경
$dbname = "your_db";   // 실제 DB명으로 변경

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("DB 연결 실패: " . $conn->connect_error);
}

$searchKey = $_GET['searchKey'] ?? 'name';
$searchValue = $_GET['searchValue'] ?? '';
$searchKey = $conn->real_escape_string($searchKey);
$searchValue = $conn->real_escape_string($searchValue);

$sql = "SELECT * FROM places WHERE $searchKey LIKE '%$searchValue%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>" . htmlspecialchars($row["category"]) . "</td>";
    echo "<td>" . htmlspecialchars($row["name"]) . "</td>";
    echo "<td>" . htmlspecialchars($row["address"]) . "</td>";
    echo "<td>" . htmlspecialchars($row["description"]) . "</td>";
    echo "</tr>";
  }
} else {
  echo "<p>일치하는 결과가 없습니다.</p>";
}
$conn->close();
?>
