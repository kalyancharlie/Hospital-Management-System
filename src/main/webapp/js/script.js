// DYNAMIC UPDATE FOR ADD DIAGNOSTICS PAGE
var diagnosticNames = [];
var diagnosticRate = [];
console.log("Script is Running");
function getDiagnosticNames() {
    var names = document.getElementById("testName");
    for(let i=0; i<names.length; i++) {
        diagnosticNames.push(names.options[i].text);
        console.log(names.options[i].text);
    }
}

function getDiagnosticRates() {
    var rates = document.getElementById("options");
    for(let i=0; i<rates.length; i++) {
        diagnosticRate.push(rates.options[i].text);
        console.log(rates.options[i].text);
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
}