require('dotenv').config();

var config = {};

config.PORT = process.env.PORT || 3000;

// The storage should be specified w.r.t directory app
config.STORAGE = process.env.STORAGE || './storages/s3Storage';

config.DESTINATION_PATH = process.env.DESTINATION_PATH || 'bucket/output';
config.INPUT_IMAGE_SOURCE = process.env.INPUT_IMAGE_SOURCE || 'bucket/input';

// These values are required for the S3 storage.
config.INPUT_BUCKET = "ac-prod-permanent";
config.OUTPUT_BUCKET = "ac-prod-processed"
config.S3_MAX_AGE = process.env.S3_MAX_AGE || 86400;

config.BASE_DESTINATION_URL = "https://d3sr7cc30ek8f4.cloudfront.net" || 'http://localhost:' + config.PORT;

module.exports = config;
