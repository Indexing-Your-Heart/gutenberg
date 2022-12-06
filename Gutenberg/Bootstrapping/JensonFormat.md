A Jenson file is represented as an object containing several fields:

- The **version** determines the version of the manifest. As the Jenson format improves over time, certain versions may include new events.
- The **application** contains information about the application that wrote the file. This field is available for Jenson files with v2 or later, and it is not required.
- The **story** contains metadata about the story this file is associated with, such as the title of the story, its author, and copyrights. This field is available for Jenson files with manifest v2 or later.
- The **timeline** is a list of Jenson events that the scene contains.

```
struct JensonFile {
	let version: Int
	let application: JensonApp?
	let story: JensonStory?
	let timeline: [JensonEvent]
}
```

```
// Example Jenson file structure.
{
	"version": 2,
	"story": { ... },
	"application": { ... },
	"timeline": [ ... ]
}
```

**Story metadata in Jenson**

Introduced in v2, the **story** field allows authors to represent metadata about the story the file represents. Files matching Jenson v2 or later must contain this metadata.

The story metadata object contains four fields:

- The `name` contains the story’s title.
- The `author` contains the name of the author.
- The `chapter` contains the chapter title, if applicable.
- The `copyright` contains a human-readable copyright string, if applicable.

```
struct JensonStory {
	let name: String
	let author: String
	let chapter: String?
	let copyright: String?
}
```

```
// Example Jenson story
{
	"name": "Othello",
	"chapter": "Act V, Scene II"
	"author": "William Shakespeare",
	"copyright": "(C) 1603 William Shakespeare. All rights reserved."
}
```

**For applications writing Jenson files**

Introduced in v2, the **application** field in the Jenson manifest should be used when a third-party application is responsible for writing Jenson files on a user’s behalf.

The application object contains two fields: the `name` field for the name of the application and an optional `website` field for the application’s website, if applicable.

```
// Example Jenson application
{
	"name": "Gutenberg",
	"website": "https://github.com/Indexing-Your-Heart/gutenberg"
}
```

**Events in Jenson**

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

**Asking questions**

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

**Refresh the scene**

Refresh events are used to update the scene in some way, both audio and visual. They consist of three main fields:

- The `kind` determines what type of data is being refreshed. This can be any of the following: `image`, `soundEffect`, `music`, `other`.
- The `resourceName` indicates what the type of data will be refreshed to. Note that this is not a full file path, and that developers will need to account for this.
- The `priority` is an optional field that contains a number representing the “layer” this data will be refreshed at.

```
struct JensonRefreshTrigger {
	let kind: JensonRefreshTriggerType
	let resourceName: String
	let priority: Int?
}
```

```
// Example Jenson refresh event
{
	"kind": "image",
	"resourceName": "BedBackground_Blurred",
	"priority": -1
}
```
