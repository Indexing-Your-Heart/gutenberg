Similar to Dialogic, a *timeline* in Jenson consists of multiple *events*. Each event can either display dialogue, present a question with choices, or perform other actions.

An event is represented as an object with several fields:

- The `type` defines the type of event, which determines how the content should be displayed.
- The `who` is a field that determines who is speaking. This field is typically left blank in non-dialogue events.
- The `what` contains the text content that will be spoken or displayed on screen.
- The `question` is an optional field that contains a question with a list of choices that will be displayed (see “[Asking questions](https://www.notion.so/The-Jenson-Format-a047308766d643d299eb82de03382801)”).
- The `refresh` is an optional trigger that indicates the user interface or display should be refreshed.

```
struct JensonEvent {
	let type: JensonEventType
	let who: String
	let what: String
	let question: JensonQuestion?
	let refresh: JensonRefreshContent?
}
```

**Types of events**

There are three primary event types in Jenson: comments, dialogue, and questions.

***Comments***

**Introduced**: Jenson v1

**Event Type Key**: `comment`

Comment events are no-op events that provide commentary or documentation. They are never displayed on screen. The comment appears in the `what` field of an event.

```
{
	"type": "comment",
	"who": "",
	"what": "This is a comment."
}
```

***Dialogue***

**Introduced**: Jenson v1

**Event Type Key**: `dialogue`

Dialogue events represent any dialogue that will be spoken; they often include conversations, monologues, and narration. Dialogue events are presented to the screen. The character speaking is stored in the `who` field, and the spoken content is presented in the `what` field.

```
{
  "type" : "dialogue",
  "who" : "Desdemon",
  "what" : "That death's unnatural that kills for loving."
}
```

***Questions***

**Introduced**: Jenson v1

**Event Type Key**: `question`

Question events contain a question with a list of choices the player has to make. Choices may contain additional dialogue. The `who` and `what` fields are typically left blank, and the question’s content is stored in the `question` property.

```
{
  "type" : "question",
  "who" : "",
  "what" : "",
	"question": { ... }
}
```

***Refresh Triggers***

**Introduced**: Jenson v2

**Event Type Key**: refresh

Refresh events contain a list of triggers to tell the reader of the file to refresh the contents of the display or user interface. Events may include music, sound effects, images, or a general “other” category.

```
{
  "type" : "refresh",
  "who" : "",
  "what" : "",
	"refresh": [ ... ]
}
```
