export default ({ filter, action, init }) => {
	// filter("items.create", (input, { collection }, { schema }) => {
	// 	console.log("Item being created: ", input);
	// 	console.log("Item being created collection: ", collection);
	// 	console.log("Item being created schema: ", schema);

	// 	console.log("Creating Item!");
	// });

	// action("items.create", () => {
	// 	console.log("Item created!");
	// });

	// init("app.before", app => {
	// 	console.log("app before:", app);
	// });

	filter("roles.delete", (input, meta, context) => {
		console.log("Role delete check", input);
		console.log("Role del check meta obj", meta);
		console.log("Role del check", context);
	});
};
