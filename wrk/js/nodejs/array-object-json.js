alert = console.log

var myArray0 = new Array ();
var myArray1 = new Array ("Hero", "Euro", "MyCat");
var myArray2 = ["Hero", "Euro", "MyCat"];
alert("== myArray0 ==");alert(myArray0);
alert("== myArray1 ==");alert(myArray1);
alert("== myArray2 ==");alert(myArray2);

var myCat0 = new Object();
myCat0.name = "Hero";
myCat0.age = 5;
myCat0.color = "silver";

var myCat1 = {
	"name": "Hero",
	"age": 5,
	"color": "silver"
};

alert("== myCat0 ==");alert(myCat0);
alert("== myCat1 ==");alert(myCat1);

alert(myCat0.name);
alert(myCat0.age);
alert(myCat0.color);

alert(myCat1["name"]);
alert(myCat1["age"]);
alert(myCat1["color"]);

//process.exit(0);

var myCats = [
	{
		"name": "Hero",
		"age": 5,
		"color": "silver"
	},
	{
		"name": "Euro",
		"age": 2,
		"color": ["brown", "white", "black"]
	}
];
alert(myCats[0]);
alert(myCats[1]);

var json = '{"myCats": [ {"name": "Hero", "age": 5, "color": "silver" }, {"name": "Euro", "age": 2, "color": ["brown", "white", "black"] }]}';
var obj = eval ("(" + json + ")");
alert('I have ' + obj.myCats.length + ' cats.');
alert(obj.myCats[0]);
alert(obj.myCats[1]);

var obj = JSON.parse(json);
alert('I have ' + obj.myCats.length + ' cats.');
alert(obj.myCats[0]);
alert(obj.myCats[1]);
