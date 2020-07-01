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
var PATINETDATE = /^[\d]{1,4}((-|:)([\d]{1,2})){2}$/;
var ALPHABETS = /^[A-Za-z ]+$/;

// REGISTRATION PAGE
function validateRegistration() {
    if(!register.ssnId.value.trim().match(PATIENTSSNID)) {
        alert("Enter only numbers less than 10 digit for SSNID");
        register.ssnId.focus();
        return false;
    }
    else if(!register.patientName.value.trim().match(ALPHABETS)) {
        alert("Please check your name");
        register.patientName.focus();
        return false;
    }
    else if(!register.patientAge.value.trim().match(PATIENTAGE)) {
        alert("Invalid Age! Try Again");
        register.patientAge.focus();
        return false;
    }
    else if(!register.dateOfAdmission.value.trim().match(PATINETDATE)) {
        alert("Please Check the Date");
        register.dateOfAdmission.focus();
        return false;
    }
    else if(register.typeOfBed.selectedIndex == 0) {
        alert("Please Select the Bed");
        register.typeOfBed.focus();
        return false;
    }
    else if(register.state.selectedIndex == 0) {
        alert("Please Select your state");
        register.state.focus();
        return false;
    }
    else if(register.city.selectedIndex == 0) {
        alert("Please select your city");
        register.city.focus();
        return false;
    }
    return true;
}

// DELETE PAGE VALIDATION & ALERTS
function validateDelete() {
    if(!search.id.value.trim().match(PATIENTID)) {
        alert("Invalid Patient ID");
        search.id.focus();
        return false;
    }
}

function confirmDelete() {
    if(confirm("Are you sure to delete this patient")) {
        return true;
    } else {
        return false;
    }
}

// UPDATE PAGE VALIDATION & ALERTS
function validateUpdate() {
    if(!update.id.value.trim().match(PATIENTID)) {
        alert("Invalid Patient ID");
        search.id.focus();
        return false;
    }
}

function confirmUpdate() {
    if(confirm("Do you want to update")) {
        return true;
    } else {
        return false;
    }
}