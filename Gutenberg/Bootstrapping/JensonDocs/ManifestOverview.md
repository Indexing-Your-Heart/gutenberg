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
