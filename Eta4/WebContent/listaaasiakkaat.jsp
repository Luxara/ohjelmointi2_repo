<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakas haku</title>


</head>
<body onkeydown="tutkiKey(event)">

<table id="listaus">
	<thead>		
		<tr>
			<th colspan= "4" id="ilmo"></th>
			<th> <a href="lisaa_asiakas.jsp" class="sivu_linkki" id="lisaa_asiakas">Lis?? asiakas</a></th>
		</tr>
		<tr>
			<th class="hakupalkki">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th colspan="2"><input type="button" value="hae" id="hakunappi" onclick="haeTiedot()"></th>
		</tr>			
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>S?hk?posti</th>
			<th></th>		
			<th></th>					
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>

<script>
haeTiedot();
document.getElementById("hakusana").focus();

function tutkiKey(event){
	if(event.keyCode==13){
		haeTiedot();
	}
}

function haeTiedot(){
	document.getElementById("tbody").innerHTML="";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{
		method: 'GET'
	})
	.then(function (response){
		return response.json()
	})
	.then(function (responseJson){
		var asiakkaat = responseJson.asiakkaat;
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){
			htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";  
        	htmlStr+="<td><a href='muuta_asiakas.jsp?asiakas_id="+asiakkaat[i].asiakas_id+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].asiakas_id+"','"+asiakkaat[i].etunimi+"','"+asiakkaat[i].sukunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
		}
		document.getElementById("tbody").innerHTML = htmlStr;
	})
}


function poista(asiakas_id, etunimi, sukunimi){
	if(confirm("Poista asiakas " + etunimi + " " + sukunimi +"?")){	
		fetch("asiakkaat/"+ asiakas_id,{
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan tietojen poisto ep?onnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + etunimi + " " + sukunimi +" tietojen poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}




</script>

</body>
</html>