function initMe() {
  var d = new Date();
  document.getElementById('datum').value = d.getFullYear() + "-" + dd(d.getMonth() + 1) + "-" + dd(d.getDate());
  document.getElementById('tijd').value = dd(d.getHours()) + ":" + dd(d.getMinutes() + 1) + ":" + dd(d.getSeconds());
}

function dd(nr) {
  return (nr < 10 ? '0' : '') + nr;
}

function fillXmlTextBox() {
  var xml = loadXml("sepa.xml");
  document.getElementById('customXml').value = xml2Txt(xml.documentElement);
}

function fillXml(evt, id) {
  var file = evt.target.files[0];
  var reader = new FileReader();
  reader.onload = function(e) { document.getElementById(id).value = e.currentTarget.result; }
  reader.readAsText(file);
}

function fillSepaXml() {
  document.getElementById('customXml').value = '';
  document.getElementById('customXml').value = diaCritics(xml2Txt(getSepaXml(document.getElementById('sepaXml').value, 'incasso.xsl')));
}

function displayResult() {
  document.getElementById("info").innerHTML = "";
  var content = document.getElementById('customXml').value;
  document.getElementById("info").appendChild(getSepaXml(content, 'sepaInfo.xsl'));
}

function excel2Xml() {
  var excel = document.getElementById('excel').value + '\n';
  var r = "  <lid>\n" + 
  "    <mandaatid>$1</mandaatid>\n" + 
  "    <mandaatdatum>$2</mandaatdatum>\n" + 
  "    <iban>$3</iban>\n" + 
  "    <naam>$4</naam>\n" + 
  "    <bedrag>$5</bedrag>\n" + 
  "  </lid>\n";
  var leden = excel.replace(/(\w.*?)\t(\w.*?)\t(\w.*?)\t(\w.*?)\t(\w.*?)\n/g, r);
  if (leden === excel) {
	console.error('excelrow does not match regex /(\w.*?)\t(\w.*?)\t(\w.*?)\t(\w.*?)\t(\w.*?)\n/g');
    return;
  }
  var vereniging = 
  "  <vereniging>\n" +
  "    <naam>" + document.getElementById('naam').value + "</naam>\n" +
  "    <iban>" + document.getElementById('iban').value + "</iban>\n" +
  "    <bic>" + document.getElementById('bic').value + "</bic>\n" +
  "    <incassantid>" + document.getElementById('incassantid').value + "</incassantid>\n" +
  "  </vereniging>\n";
  var incasso =
  "  <incasso>\n" +
  "    <datum>" + document.getElementById('datum').value + "</datum>\n" +
  "    <tijd>" + document.getElementById('tijd').value + "</tijd>\n" +
  "    <kenmerk>" + document.getElementById('kenmerk').value + "</kenmerk>\n" +
  "  </incasso>\n";
  document.getElementById('excelXml').value = "<sepa>\n" + incasso + vereniging + leden + "</sepa>";
  var sepaXml = document.getElementById('excelXml').value;
  document.getElementById('customXml').value = sepaXml;
  document.getElementById('sepaXml').value = diaCritics(xml2Txt(getSepaXml(sepaXml, "sepa.xsl")));
}

function saveTextAsXmlFile() {
  var sepaXml = document.getElementById('customXml').value;
  if (sepaXml == '') {
    console.error('Nog niets om te zetten.');
    return;
  }
  var downloadLink = document.createElement("a");
  downloadLink.download = "incasso.xml";
  downloadLink.innerHTML = "Download File";
  var content = diaCritics(xml2Txt(getSepaXml(sepaXml, "sepa.xsl")));
  document.getElementById('sepaXml').value = content;
  downloadLink.href = URL.createObjectURL(getXmlFileAsBlob(content));
  downloadLink.click();
}

function getXmlFileAsBlob(txt) {
  return new Blob([txt], { type: 'text/xml' });
}

function getSepaXml(xml, xslName) {
  var xsltProcessor = new XSLTProcessor();
  var xml = xmlFromText(xml);
  var xsl = loadXml(xslName);
  xsltProcessor.importStylesheet(xsl);
  return xsltProcessor.transformToFragment(xml, document);
}

function diaCritics(txt) {
	return txt
	.replace(/ë/g, '-e')
	.replace(/ä/g, '-a')
	.replace(/ü/g, '-u')
	.replace(/ï/g, '-i')
	.replace(/ö/g, '-o')
	.replace(/ÿ/g, '-y')
	.replace(/é/g, 'e')
	.replace(/á/g, 'a')
	.replace(/ú/g, 'u')
	.replace(/í/g, 'i')
	.replace(/ó/g, 'o')
	.replace(/ý/g, 'y')
	.replace(/è/g, 'e')
	.replace(/à/g, 'a')
	.replace(/ù/g, 'u')
	.replace(/ì/g, 'i')
	.replace(/ò/g, 'o');
}

function xml2Txt(xml) {
  var div = document.createElement('div');
  div.appendChild(xml.cloneNode(true));
  return div.innerHTML.replace(/&gt;/g, '>').replace(/&lt;/g, '<');
}

function loadXml(filename) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("GET", filename, false);
  try {xhttp.responseType = "text"} catch(err) {} // Helping IE11
  xhttp.send("");
  return xhttp.responseXML;
}

function xmlFromText(txt) {
  var parser = new DOMParser();
  return parser.parseFromString(txt, "text/xml");
}

