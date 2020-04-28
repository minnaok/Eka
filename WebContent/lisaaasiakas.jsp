<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="script/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="tyyli.css"></link>

<title>Asiakkaan lisäys</title>
</head>
<body>
<form id="asiakaslisays">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><input type="submit" id="takaisin" value= "Takaisin listaukseen ja hakuun"></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	$("#asiakaslisays").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 2				
			},	
			sukunimi:  {
				required: true,
				minlength: 2				
			},
			puhelin:  {
				required: true,
				number: true,
				minlength: 4,
				maxlength: 10
			},
			sposti:  {
				required: true,
				minlength: 1
			}	
		},
		messages: {
			etunimi: {     
				required: "Anna etunimi",
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Anna sukunimi",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Anna puhelinnumero",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			sposti: {
				required: "Anna sähköpostiosoite",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			lisaaUusiasiakas();
		}		
	}); 	
});

function lisaaUusiasiakas(){	
	var formJsonStr = formDataJsonStr($("#asiakaslisays").serializeArray()); 
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}
</script>
</body>
</html>