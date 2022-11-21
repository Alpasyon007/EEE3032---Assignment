DATASET_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\msrc_objcategimagedatabase_v2';
DESCRIPTOR_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\descriptors';

GLOBAL_AVERAGE_RGB_FOLDER='globalRGBaverage';
GLOBAL_RGB_HISTOGRAM_FOLDER='globalRGBhisto';
SPATIAL_GRID_FOLDER='spatialGrid';
EDGE_ORIENTATION='edgeOrientation';
HARRIS_FEATURES='harrisFeatures';

ComputeDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, GLOBAL_AVERAGE_RGB_FOLDER, @ComputeGlobalColour);
ComputeDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, GLOBAL_RGB_HISTOGRAM_FOLDER, @ComputeRGBHistogram, 4);
ComputeDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, SPATIAL_GRID_FOLDER, @ComputeSpatialGrid, [4, 4]);
ComputeDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, HARRIS_FEATURES, @ComputeHarrisFeatures, [50, 32])