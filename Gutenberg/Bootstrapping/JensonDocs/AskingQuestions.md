Questions in Jenson are represented with a question object, which contains two primary fields:

- The `question` field contains the question being asked.
- The `options` field contains a list of choices the player can make.

```
struct JensonQuestion {
	let question: String
	let options: [JensonChoice]
}
```

```
// Example Jenson question
{
	"question": "Alas, why gnaw you so your nether lip?",
	"options": [
		{
			"name": "Peace, and be still!",
			"events": [ ... ]
		}
	]
}
```

***Choices***

Choices are represented as object with two fields:

- The `name` represents the text content displayed on screen when the player makes a choice.
- The `events` fields contains a list of events that play when this choice is selected.

```
struct JensonChoice {
	let name: String
	let events: [JensonEvent]
}
```

```
// Example Jenson choice
{
	"name": "Peace, and be still!",
	"events": [ ... ]
}
```
