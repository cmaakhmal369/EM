// Folder Structure:
// /sales-leaderboard
//    ├── index.html  (fail utama)
//    ├── styles.css  (CSS styling)
//    ├── script.js   (fungsi JavaScript)
//    ├── images/     (folder untuk gambar)

// index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ENRICH MASTER Sales Leaderboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>🏆 ENRICH MASTER Sales Leaderboard 🏆</h1>
        <input type="text" id="name" placeholder="Masukkan Nama">
        <input type="number" id="sales" placeholder="Jumlah Sales (RM)">
        <input type="file" id="imageUpload" accept="image/*">
        <button onclick="addSales()">Tambah Sales</button>
        
        <div class="leaderboard" id="leaderboard"></div>
    </div>
    
    <script src="script.js"></script>
</body>
</html>

// styles.css
body {
    font-family: Arial, sans-serif;
    text-align: center;
    background-color: #f4f4f4;
}
.container {
    width: 80%;
    margin: 20px auto;
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}
input, button {
    margin: 5px;
    padding: 10px;
}
.leaderboard {
    margin-top: 20px;
}
.entry {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}
.entry img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
}

// script.js
let salesData = [];
function addSales() {
    const name = document.getElementById('name').value;
    const sales = parseFloat(document.getElementById('sales').value);
    const file = document.getElementById('imageUpload').files[0];
    
    if (!name || isNaN(sales)) {
        alert("Sila isi nama dan jumlah sales!");
        return;
    }
    
    const reader = new FileReader();
    reader.onload = function(e) {
        salesData.push({ name, sales, image: e.target.result });
        salesData.sort((a, b) => b.sales - a.sales);
        salesData = salesData.slice(0, 10); 
        updateLeaderboard();
    };
    
    if (file) {
        reader.readAsDataURL(file);
    } else {
        salesData.push({ name, sales, image: 'images/default.png' });
        salesData.sort((a, b) => b.sales - a.sales);
        salesData = salesData.slice(0, 10);
        updateLeaderboard();
    }
}

function updateLeaderboard() {
    const leaderboard = document.getElementById('leaderboard');
    leaderboard.innerHTML = '';
    salesData.forEach((entry, index) => {
        leaderboard.innerHTML += `
            <div class="entry">
                <span>#${index + 1}</span>
                <img src="${entry.image}" alt="Profile">
                <span>${entry.name}</span>
                <span>RM ${entry.sales.toFixed(2)}</span>
            </div>
        `;
    });
}
