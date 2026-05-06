#!/usr/bin/env bash
# Downloads every paper + slide PDF referenced on the homepage from
# faculty.washington.edu/wlloyd into local papers/ and slides/ folders.
# Run from inside the robertcordingly.github.io repo:
#   chmod +x download_papers.sh && ./download_papers.sh
set -e

BASE="https://faculty.washington.edu/wlloyd"
mkdir -p papers slides

PAPERS=(
  "WoSC11_2025_ServerlessLLM.pdf"
  "Cordingly_CPU_Distribution_Manipulation_UCC2025-cr.pdf"
  "DistFaaSRunner-camera-ready.pdf"
  "graphql-camera-ready.pdf"
  "ucc-2024-camera-ready.pdf"
  "wosc2024-final73.pdf"
  "IEEECloudSummit_JasleenKaur-cameraready.pdf"
  "ic2e_2023_cordingly.pdf"
  "ic2e_2023_PhD_Sym.pdf"
  "MoCloudCom2023proof.pdf"
  "XinghanChen_WOSC2023_paper_camera_ready.pdf"
  "Bhaia_ContainerIsolationPaper-cameraready.pdf"
  "SAAF_Memory_Configuration_IC2E2022.pdf"
  "FaaSET-paper-final.pdf"
  "hotcloudperf_lambda_variability_final.pdf"
  "SterlingQuinn.pdf"
  "ICPE_SAAF_proof.pdf"
  "SAAF-Paper24.pdf"
  "saaf_cbdcom_camera_ready.pdf"
  "cbdcom_FaaSProgrammingLanguagePaper_camera_ready.pdf"
)

SLIDES=(
  "DistributedFaaSRunnerIC2ESlides.pdf"
  "graphql-ic2e-slides.pdf"
  "ucc-2024-slides.pdf"
  "wosc2024-slides.pdf"
  "2024-cloud-summit-slides.pdf"
  "Cordingly_IC2E2023_slides_2up.pdf"
  "cordingly_ic2e_2023_PhD_Sym-slides.pdf"
  "cloudcom-2023.pdf"
  "wosc_2023_slides.pdf"
  "WoC-2023-slides.pdf"
  "ic2e2022_CPUTAMS_slides.pdf"
  "HotCloudPerf_2022_FaaSET-notebook-slides.pdf"
  "hotcloudperf_lambda_variability_slides.pdf"
  "WOSC7-slides-p3.pdf"
  "SAAF_Tutorial_Slides.pdf"
  "SAAF-WOSC-slides.pdf"
  "SAAF_slides-2-Up.pdf"
  "Lang-slides-2-Up.pdf"
)

echo "Downloading ${#PAPERS[@]} papers into ./papers/ ..."
for f in "${PAPERS[@]}"; do
  if [ -f "papers/$f" ]; then
    echo "  [skip] papers/$f already exists"
  else
    echo "  [get ] $f"
    curl -fsSL --retry 3 -o "papers/$f" "$BASE/papers/$f" \
      || echo "  [FAIL] $f -- check URL"
  fi
done

echo ""
echo "Downloading ${#SLIDES[@]} slide decks into ./slides/ ..."
for f in "${SLIDES[@]}"; do
  if [ -f "slides/$f" ]; then
    echo "  [skip] slides/$f already exists"
  else
    echo "  [get ] $f"
    curl -fsSL --retry 3 -o "slides/$f" "$BASE/slides/$f" \
      || echo "  [FAIL] $f -- check URL"
  fi
done

echo ""
echo "Done. Summary:"
echo "  papers/: $(ls papers | wc -l | tr -d ' ') files"
echo "  slides/: $(ls slides | wc -l | tr -d ' ') files"
