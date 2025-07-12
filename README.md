# A nucleation distance sets the cell size-dependent P-body assembly
## Introduction
Here are models we used in our paper [A nucleation distance sets the cell size-dependent P-body assembly](https://www.biorxiv.org/content/10.1101/2025.07.08.663506v1).  We develop a conceptual framework that models phase-separation nucleation. 

As shown in the [Paper](https://www.biorxiv.org/content/10.1101/2025.07.08.663506v1), We find that small cells contain fewer but larger P-bodies, whereas large cells form more but smaller granules. Monte Carlo simulations of P-body nucleation accurately recapitulate these cell size-dependent patterns and reveal a nucleation distance of 2.2 µm. Furthermore, we demonstrate that increasing vacuolar volume reduces the effective cytoplasmic space and correspondingly raises P-body number, although cell size remains the dominant determinant.
## Model explanation
<img width="1194" height="587" alt="Image" src="https://github.com/user-attachments/assets/0f5e1000-2de4-4159-92be-bfec8722e8a7" />

This is the model visualization for "model_without_nuclear". To test whether simple geometric constraints could explain the empirically observed scaling, we implemented a Monte Carlo simulation based on nucleation.

<img width="773" height="279" alt="Image" src="https://github.com/user-attachments/assets/b257feec-6f24-45cd-8298-f2ae2f5ba3d9" />

This figure demonstrates the procedural steps undertaken by the model during execution.
