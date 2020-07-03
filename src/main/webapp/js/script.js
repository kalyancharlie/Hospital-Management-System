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
    if(medicineQuantity[selectedIndex] >= qty && qty > 0) {
        document.getElementById("injectMedicineQuantity").value = qty;
        rate = parseInt(medicineRate[selectedIndex]);
        total = parseInt(medicineRate[selectedIndex]*qty);
        document.getElementById("injectMedicineRate").innerHTML = rate;
        document.getElementById("injectMedicineAmount").innerHTML = total;
    } else {
        alert("Selected Quantity is not Available. Please choose Less Amount");
        addMedicines.qty.focus();
        return false;
    }
}

// FORM VALIDATIONS

// REGULAR EXPRESSIONS

var USERID = /^[a-z][a-z0-9]{7,}$/;
var PASSWORD = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{10,}$/;
var PATIENTSSNID = /^[\d]{1,9}$/;
var PATIENTID = /^[1-9][\d]{8}$/;
var PATIENTAGE = /^[1-9][\d]{0,2}$/;
var PATINETDATE = /^[\d]{1,4}((-|:)([\d]{1,2})){2}$/;
var PATIENTADDRESS = /^[a-zA-Z0-9 :_,.-]{10,}$/;
var ALPHABETS = /^[A-Za-z ]+$/;
var PAGENUMBER = /^[1-9][1-9]*$/;

// LOGIN PAGE
function validateLogin() {
    if(!login.username.value.trim().match(USERID)) {
        alert("Enter valid Username");
        login.username.focus();
        return false;
    }
    else if(!login.password.value.trim().match(PASSWORD)) {
        alert("Password must contain min of 10 digits");
        login.password.focus();
        return false;
    }
    return true;
}

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
    else if(!register.address.value.trim().match(PATIENTADDRESS)) {
        alert("Enter complete address");
        register.address.focus();
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
    return confirm("Do you want to Register?");
}

// DELETE PAGE & SEARCH PAGE VALIDATION & ALERTS
function validateDelete() {
    if(!search.id.value.trim().match(PATIENTID)) {
        alert("Invalid Patient ID");
        search.id.focus();
        return false;
    }
    return true;
}

function confirmDelete() {
    if(deletes.id.value.match(PATIENTID)) {
        if(confirm("Are you sure to delete this patient")) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("Please Enter Id to Delete");
        search.id.focus();
        return false;
    }
}

// UPDATE PAGE VALIDATION & ALERTS
function validateUpdate() {
    if(!update.id.value.trim().match(PATIENTID)) {
        alert("Invalid Patient ID. Enter ID of length 10");
        update.id.focus();
        return false;
    } else {
        return true;
    }
}

function confirmUpdate() {
    if(updates.id.value.trim().match(PATIENTID)) {
        if(confirm("Do you want to update")) {
            return true;
        } else {
            return false;
        }
    } else if(updates.id.value == null || updates.id.value == "") {
        alert("Please Enter Id to Update");
        update.id.focus();
        return false;
    }
    return true;
}

// PATIENT BILLING VALIDATION & ALERTS

function validateBilling() {
    return validateDelete();
}

function confirmBilling() {
    if(confirm("Do you want to Discharge the Patient")) {
        return true;
    } else {
        return false;
    }
}

// ISSUE MEDICINES PAGE VALIDATION & ALERTS

function validateMedicines() {
    return validateDelete();
}

function confirmAddMedicines() {
    if(addMedicines.medicineName.selectedIndex == 0) {
        alert("There is no Medicine selected. Select Medicine to add");
        addMedicines.medicineName.focus();
        return false;
    } 
    else if(addMedicines.qty.value == "" || addMedicines.qty.value == null) {
        alert("There is no Quantity Entered. Please enter valid qty");
        addMedicines.qty.focus();
        return false;
    } 

    if(confirm("Do you want to add this Medicine?")) {
        return true;
    } else {
        addMedicines.qty.focus();
        return false;
    }
}

function confirmMedicines() {
	if(document.getElementById("medicineNameCheck") == null || document.getElementById("medicineNameCheck").value == "") {
        alert("There are no medicines added to update");
        addMedicines.medicineName.focus();
        return false;
    } else {
        if(confirm("Do you want to update medicines?")) {
            return true;
        } else {
            return false;
        }
    }
}

// ADD DIAGNOSTICS PAGE VALIDATION & ALERTS

function validateDiagnostics() {
    return validateDelete();
}

function confirmAddDiagnostics() {
    if(addDiagnostics.testName.selectedIndex == 0) {
        alert("There is no Diagnostic selected. Select Diagnostic to add");
        addDiagnostics.testName.focus();
        return false;
    }

    if(confirm("Do you want to add this Diagnostic?")) {
        return true;
    } else {
        addDiagnostics.testName.focus();
        return false;
    }
}

function confirmDiagnostics() {
	if(document.getElementById("diagnosticNameCheck") == null || document.getElementById("diagnosticNameCheck").value == "") {
        alert("There are no Diagnostics added to update");
        addDiagnostics.testName.focus();
        return false;
    } else {
        if(confirm("Do you want to update Diagnostics?")) {
            return true;
        } else {
            return false;
        }
    }
}

// SEARCH PAGE VALIDATION & ALERTS

function validateSearchPageNumber() {
    console.log(searchpage.customPageNumber.value);
    if(!searchpage.customPageNumber.value.trim().match(PAGENUMBER)) {
        alert("Enter valid page number");
        searchpage.customPageNumber.focus();
        return false;
    }
    return true;
}

function disablePrev() {
    var para = document.getElementById("currentNumber").textContent;
    var current = parseInt(para[6]);
    console.log(para);
    console.log(current);
    if(current == 1) {
        document.getElementById("prev").disabled = true;
    }
}

document.getElementById("prev").onload = disablePrev();

function disableNext() {
    var total = parseInt(nextpage.total.value);
    var current = parseInt(nextpage.pageNo.value);
    if(current-1 == total) {
        document.getElementById("next").disabled = true;
    }
}

document.getElementById("next").onload = disableNext();