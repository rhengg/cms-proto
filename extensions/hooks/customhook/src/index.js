const resolutions = process.env["AWS_RESOLUTIONS"].split(",");
const resolutionSuffix = process.env["AWS_OUTPUT_RESOLUTIONS_SUFFIX"].split(
	","
);
const baseURL = process.env["AWS_OUTPUT_BASE_URL"];

const createVideoDeliveryUrls = videoId => {
	let videoDeliveryUrls = [];
	resolutions.map((res, index) => {
		videoDeliveryUrls.push({
			resolution: res,
			url: `${baseURL}/${videoId}/${videoId}_${resolutionSuffix[index]}.m3u8`
		});
	});

	return videoDeliveryUrls;
};

export default (
	{ filter },
	{ services, exceptions, database, getSchema, env, logger, emitter }
) => {
	filter(
		"movies.items.create",
		async (input, { collection }, { schema, database }) => {
			const deliveryUrls = createVideoDeliveryUrls(input.movie_raw);

			return { ...input, movie_delivery_url: deliveryUrls };
		}
	);

	// filter("movies.items.update", input => {
	// 	const suffix = process.env["AWS_OUTPUT_RESOLUTIONS_SUFFIX"];
	// 	const suffixArray = suffix.split(",");
	// 	console.log("check console for env vars", suffixArray);
	// });
};

// field: movie_delivery_url
/* 
  Before create:
  1. get s3 uuid
  2. create destination_urls object from env vars
  3. modify input
  4. return modified input for next processing

  Before update:
  1. Check if upload uuid has changed
  2. If changed, alter destination urls
  3. Invoke lambda to delete previous video files(raw, input and delivery)
  3. If unchanged, return input as is.
*/

// base_url/<uuid>/<uuid>_resolution.m3u8

// 1080: https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/7f8ec263-7ea3-4639-af95-3876288fb171/7f8ec263-7ea3-4639-af95-3876288fb171_3000.m3u8

// 540: https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/7f8ec263-7ea3-4639-af95-3876288fb171/7f8ec263-7ea3-4639-af95-3876288fb171_1500.m3u8

// 480: https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/7f8ec263-7ea3-4639-af95-3876288fb171/7f8ec263-7ea3-4639-af95-3876288fb171_750.m3u8

// 360: https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/7f8ec263-7ea3-4639-af95-3876288fb171/7f8ec263-7ea3-4639-af95-3876288fb171_325.m3u8
