ROBOT PART SWAPPER

A lightweight Unity Editor tool for swapping mesh variants on Mech_00 — no Play Mode required.

Robot Part Swapper lets you mix and match different mesh variants for each
body part of your robot directly in the Inspector. Changes are reflected
live in the Scene view, fully support Undo, and are saved with the scene.

---
 Component
---
RobotPartSwapper.cs

Add this component to your robot's root GameObject. It holds a list of
Body Parts (Arm, Forearm.L, Forearm.R, Leg, Thigh, Shoulder, Thigh, Torso by default).
Each part stores:
- A Target Renderer: the SkinnedMeshRenderer on the robot that gets modified.
- A list of Variants: each variant holds a mesh, its materials, and an
  optional list of objects to hide when active (useful for avoiding
  clipping between parts).

RobotPartSwapperEditor.cs


This script it has to be in an "Editor" folder to work

A custom Inspector that replaces the default Unity UI with two modes:

Normal Mode: a clean dropdown per body part. Select a variant from
the list to instantly swap the mesh in the Scene.

Setup / Debug Mode: toggle this on for first-time setup. Exposes
two utility buttons:

Find and Add Parts from Folder: point it at a folder in your
project and it will scan for meshes, prefabs, Fbx and matching them to
body parts by name automatically.

Auto-Assign Target Renderers: scans the robot's child objects
and wires each SkinnedMeshRenderer to its matching body part by name.

---
 How to use
---
1. ADD THE COMPONENT
   Select your robot's root GameObject and add the RobotPartSwapper component.
2. RUN THE SETUP TOOLS (first time only)
   In the Inspector, enable "Show Setup / Debug Mode".

 - Click "Auto-Assign Target Renderers" to automatically link the
     SkinnedMeshRenderers on the robot's children to each body part.

 - Set your Search Folder path and click "Find and Add Parts from Folder"
     to auto-populate mesh variants from your project assets.

TIP: Asset names should include the part name as a segment,
e.g. Basic_L_Arm or Basic_S_Torso. The tool matches by
splitting on underscore ( _ ).

3. SWAP PARTS
   Disable Setup Mode. Use the dropdowns in the Inspector to select a
   variant for each body part. The mesh updates instantly in the Scene view.
4. MUTUALLY EXCLUSIVE PARTS (optional)
   In the variant settings, enable "Mutually Exclusive" and assign any
   GameObjects that should be hidden when that variant is active — for
   example, hiding a shoulder pad when a bulkier arm is selected.


---
Notes
---
All swaps support Undo / Redo (Ctrl+Z).
Body part names are case-insensitive when auto-matching.
You can rename or extend the default body parts list directly in the component.
The component is safe to leave on the GameObject in a build; it has no
runtime overhead unless you call SwapPart() from code.


----
Included prefabs

The prefabs included in this asset already have the RobotPartSwapper component
added and configured on the root GameObject. Simply drag a prefab into your
scene and the tool is ready to use — no additional setup required.
