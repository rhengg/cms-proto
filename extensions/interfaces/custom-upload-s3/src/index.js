import InterfaceComponent from "./interface.vue";

export default {
	id: "custom",
	name: "Upload S3",
	icon: "box",
	description: "Upload to s3 with custom properties and behaviours",
	component: InterfaceComponent,
	options: null,
	groups: ["file", "files"],
	types: ["uuid"],
	recommendedDisplays: ["image"]
};
