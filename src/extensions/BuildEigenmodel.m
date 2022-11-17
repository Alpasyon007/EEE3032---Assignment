function [eigenBuild, eigenDeflated, ALLFEATPCA]=BuildEigenmodel(ALLFEAT)

    eigenBuild=Eigen_Build(ALLFEAT');
    eigenDeflated=Eigen_Deflate(eigenBuild, "keepn", 3);
    ALLFEATPCA=Eigen_Project(ALLFEAT', eigenDeflated)';

return;