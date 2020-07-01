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

// FORM VALIDATIONS

// REGULAR EXPRESSIONS

var PATIENTSSNID = /^[\d]{1,9}$/;
var PATIENTID = /^[1-9][\d]{8}$/;
var PATIENTAGE = /^[1-9][\d]{0,2}$/;
var PATINETDATE = /^([\d]{1,2}(-|:)){2}[\d]{1,4}$/;
var ALPHABETS = /^[A-Za-z]+$/;

// REGISTRATION PAGE

var ssnId = document.getElementById("ssnId");
var name = document.getElementById("patientName");
var age = document.getElementById("patientAge");
var bed = document.getElementById("typeOfBed");
var address = document.getElementById(address);
var city = document.getElementById("city");
var state = document.getElementById("state");
console.log(ssnId);
console.log(name);
console.log(age);
console.log(bed);
console.log(address);
console.log(city);
console.log(state);

function validateId() {
    if(true) {
        return true; 
    } else {
        alert("Enter Id with Length of 10 only Numbers ");
        return false;
    }
}