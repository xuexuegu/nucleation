# A nucleation distance sets the cell size-dependent P-body assembly
## Introduction
Here are models we used in our paper [A nucleation distance sets the cell size-dependent P-body assembly](https://www.biorxiv.org/content/10.1101/2025.07.08.663506v1).  We develop a conceptual framework that models phase-separation nucleation. 

As shown in the [Paper](https://www.biorxiv.org/content/10.1101/2025.07.08.663506v1), We find that small cells contain fewer but larger P-bodies, whereas large cells form more but smaller granules. Monte Carlo simulations of P-body nucleation accurately recapitulate these cell size-dependent patterns and reveal a nucleation distance of 2.2 µm. Furthermore, we demonstrate that increasing vacuolar volume reduces the effective cytoplasmic space and correspondingly raises P-body number, although cell size remains the dominant determinant.
## Model explanation
This is the model visualization for "model_without_nuclear". To test whether simple geometric constraints could explain the empirically observed scaling, we implemented a Monte Carlo simulation based on nucleation.
<img width="861" height="587" alt="Image" src="https://github.com/user-attachments/assets/0f5e1000-2de4-4159-92be-bfec8722e8a7" />


This figure demonstrates the procedural steps undertaken by the model during execution.
<img width="861" height="314" alt="Image" src="https://github.com/user-attachments/assets/b257feec-6f24-45cd-8298-f2ae2f5ba3d9" />


This Figure shows schematic diagrams of three nucleation models in a cell containing a centrally located organelle (gray circle). We implemented three distinct models to simulate molecule fusion paths in the presence of a central spherical nucleus and vacuole, representing non-permissive organelle space.  
Model 1: path-restricted fusion-Molecules fuse with their closest neighbor only if the connecting line does not intersect the central organelle.  
Model 2: path-shifted fusion-Molecules fuse with their closest neighbor even if the direct path crosses the nucleus, but the merged granule is repositioned to avoid overlap with the central organelle.  
Model 3: path-redirected fusion-Molecules fuse with their closest neighbor based on the true shortest path around the nucleus, allowing nucleus-aware trajectories.
<img width="861" height="314" alt="Image" src="https://github.com/user-attachments/assets/a2812711-91fe-4ce6-a039-3f557be75668" />
## Usage
For all model, to get the data, run
``calculate.m``.  
Model 2 and Model 3 utilize the same document, differing only in the implementation of the ``findclosestpoint.m``.   
For model 2, run``closest_distance = sum((targetPoint-points(closest_index,:)).^2)``  
For model 3, run ``closest_distance = calculateShortestPath(targetPoint, points(closest_index,:), r1, r2);``


