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


//For Registration Page

function validateForm() {
	  var ssnId = document.register.ssnId;
	  var name = document.register.patientName;
	  var age = document.register.patientAge;
	  var bed = document.register.typeOfBed;
	  var address = document.register.address;
	  var city = document.register.city;
	  var state = document.register.state
	  var letters = /^[A-Za-z]+$/;
	  var age1 = /^\d{1,3}$/;
	  var id = /^\d{9}$/;
	  var address = /^[0-9a-zA-Z]+$/;

	  if(!(ssnId.value.match(id))){
		  alert('Enter must 9 digit number only');
		  return false;
	  }
	  else if(!(name.value.match(letters)))
	  {
		 alert('enter only alphabates');
	    return false;
	  }
	   else if(!(age.value.match(age1))){
		   alert('Please enter your age');
		   return false;
	   }
	   else if(bed.value.equals(null) || bed.value.equals("") ||bed==null)
	   {
	   alert('Select Type of bed from the list');
	   return false;
	   }
	   else if(!(address.value.match(address)))
		  {
		   alert('Please enter your address');
		  return false;
		  }
	   else if(city.value == "none")
	   {
	   alert('Select your city from the list');
	   return false;
	   }
	   else if(state.value == "none")
	   {
	   alert('Select your state from the list');
	   return false;
	   }
return true;
}
