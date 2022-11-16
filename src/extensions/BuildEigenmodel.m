function [eigenBuild, eigenDeflated, ALLFEATPCA]=BuildEigenmodel(ALLFEAT)

    eigenBuild=Eigen_Build(ALLFEAT');
    eigenDeflated=Eigen_Deflate(eigenBuild, "keepn", 3);
    ALLFEATPCA=Eigen_Project(ALLFEAT', eigenDeflated)';
    
    plot3(ALLFEATPCA(:,1),ALLFEATPCA(:,2),ALLFEATPCA(:,3),'bx');
    xlabel('eigenvector1');
    ylabel('eigenvector2');
    zlabel('eigenvector3');
return;