// DYNAMIC UPDATE FOR ADD DIAGNOSTICS PAGE
var diagnosticNames = [];
var diagnosticRate = [];
console.log("Script is Running");
function getDiagnosticNames() {
    var names = document.getElementById("testName");
    for(let i=0; i<names.length; i++) {
        diagnosticNames.push(names.options[i].text);
    }
}

function getDiagnosticRates() {
    var rates = document.getElementById("options");
    for(let i=0; i<rates.length; i++) {
        diagnosticRate.push(rates.options[i].text);
    }
}

function getRateByName() {
    getDiagnosticNames();
    getDiagnosticRates();
    
    var selectedIndex = document.getElementById("testName").selectedIndex;
    console.log("Rate Index",selectedIndex);
    console.log("Rate:", diagnosticRate[selectedIndex]);
    document.getElementById("injectAmount").innerHTML = diagnosticRate[selectedIndex];
    document.getElementById("injectDiagnosticId").value = selectedIndex;
    console.log("Selected Diagnostic with id",selectedIndex, "of cost ",diagnosticRate[selectedIndex]);
}

// DYNAMIC UPDATE FOR ADD MEDICINES PAGE
var medicineNames = [];
var medicineQuantity = [];
var medicineRate = [];

function getMedicineNames() {
    var names = document.getElementById("medicineName");
    for(let i=0; i<names.length; i++) {
        medicineNames.push(names.options[i].text);
    }
}

function getMedicineQuantities() {
    var quantities = document.getElementById("medicineQuantity");
    for(let i=0; i<quantities.length; i++) {
        medicineQuantity.push(quantities.options[i].text);
    }
}

function getMedicineRates() {
    var rates = document.getElementById("medicineRate");
    for(let i=0; i<rates.length; i++) {
        medicineRate.push(rates.options[i].text);
    }
}

function getMedicineByName1() {
    getMedicineNames();
    getMedicineRates();
    var selectedIndex = 0;
    var rate = 0;
    
    selectedIndex = parseInt(document.getElementById("medicineName").selectedIndex);
    rate = parseInt(medicineRate[selectedIndex]);
    document.getElementById("injectMedicineRate").innerHTML = rate;
    document.getElementById("injectMedicineId").value = selectedIndex;
}

function getMedicineByName2() {
    var qty = parseInt(document.getElementById("qty").value);
    var rate = 0;
    var total = 0;
    var selectedIndex = 0;
    getMedicineNames();
    getMedicineQuantities();
    getMedicineRates();

    selectedIndex = parseInt(document.getElementById("medicineName").selectedIndex);
    document.getElementById("injectMedicineId").value = selectedIndex;
    if(medicineQuantity[selectedIndex] >= qty) {
        document.getElementById("injectMedicineQuantity").value = qty;
        rate = parseInt(medicineRate[selectedIndex]);
        total = parseInt(medicineRate[selectedIndex]*qty);
        document.getElementById("injectMedicineRate").innerHTML = rate;
        document.getElementById("injectMedicineAmount").innerHTML = total;
    } else {
        alert("Selected Quantity is not Available. Please choose Less Amount");
    }
}