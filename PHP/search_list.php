<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "localhost";
$username = "dbuser";   // 실제 사용자명으로 변경
$password = "dbpass";   // 실제 비밀번호로 변경
$dbname = "your_db";    // 실제 DB 이름으로 변경

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("DB 연결 실패: " . $conn->connect_error);
}

$searchKey = $_GET['searchKey'] ?? null;
$searchValue = $_GET['searchValue'] ?? null;

$searchKey = $conn->real_escape_string($searchKey);
$searchValue = $conn->real_escape_string($searchValue);

// 쿼리 구성
if (!$searchKey && !$searchValue) {
  $sql = "SELECT * FROM places";
} else if ($searchKey && !$searchValue) {
  $sql = "SELECT * FROM places";
} else {
  $sql = "SELECT * FROM places WHERE $searchKey LIKE '%$searchValue%'";
}

$result = $conn->query($sql);

// 결과 출력
if ($result && $result->num_rows > 0) {
  echo "<table border='1' cellpadding='10'>";
  echo "<tr>
          <th>카테고리</th>
          <th>장소명</th>
          <th>주소</th>
          <th>설명</th>
        </tr>";
  while($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>" . htmlspecialchars($row["category"]) . "</td>";
    echo "<td>" . htmlspecialchars($row["name"]) . "</td>";
    echo "<td>" . htmlspecialchars($row["address"]) . "</td>";
    echo "<td>" . $row["description"] . "</td>"; // 설명은 HTML이 포함될 수 있으니 이스케이프 안 함
    echo "</tr>";
  }
  echo "</table>";
} else {
  echo "<p>일치하는 결과가 없습니다.</p>";
}

$conn->close();
?>
