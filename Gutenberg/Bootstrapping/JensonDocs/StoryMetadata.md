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
