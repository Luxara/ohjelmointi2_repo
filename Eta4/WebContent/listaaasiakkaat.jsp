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
<body>

<table id="listaus">
	<thead>		
		<tr>
			<th colspan="6" class="sivu_linkki"><span id="lisaa_asiakas">Lisää asiakas</span></th>
		</tr>
		<tr>
			<th class="hakupalkki">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th colspan="2"><input type="button" value="hae" id="hakunappi"></th>
		</tr>			
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>		
			<th></th>					
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>
$(document).ready(function(){
	
	$("#lisaa_asiakas").click(function(){
		document.location="lisaa_asiakas.jsp"
	});
	
	haeAsiakkaat();
	
	$("#hakunappi").click(function(){		
		haeAsiakkkaat();
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ 
			  haeAsiakkaat();
		  }
	});
	$("#hakusana").focus();
});	


function haeAsiakkaat(){
	$("#listaus tbody").empty();
	
	$.ajax({
		url:"asiakkaat/"+$("#hakusana").val(), 
		type:"GET", 
		dataType:"json", 
		success:function(result){		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><a class='muuta' href='muuta_asiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a></td>";
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"','"+field.etunimi+"','"+field.sukunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
	
function poista(asiakas_id, etunimi, sukunimi){
	console.log(asiakas_id+ " " + etunimi + " " + sukunimi);
	if(confirm("Haluatko varmasti poistaa asiakkaan " + etunimi + " " + sukunimi + "?")){
		$.ajax({url:"asiakkaat/" + asiakas_id, type:"DELETE", dataType:"json", success:function(result){
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poisto epäonnistui.");
			}else if(result.response==1){
				$("#rivi_"+asiakas_id).css("background-color", "red");
				alert("Asiakkaan " + etunimi + " " + sukunimi + " onnistui.");
				haeAsiakkaat();
			}
	}});
}
}	


</script>

</body>
</html>