<?php
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

$sql = "SELECT * FROM night_views WHERE $searchKey LIKE '%$searchValue%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    echo "<div>";
    echo "<h3>" . htmlspecialchars($row["name"]) . "</h3>";
    echo "<p>주소: " . htmlspecialchars($row["address"]) . "</p>";
    echo "<p>설명: " . htmlspecialchars($row["description"]) . "</p>";
    echo "</div>";
  }
} else {
  echo "<p>일치하는 결과가 없습니다.</p>";
}
$conn->close();
?>
