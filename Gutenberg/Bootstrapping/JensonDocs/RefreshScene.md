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
