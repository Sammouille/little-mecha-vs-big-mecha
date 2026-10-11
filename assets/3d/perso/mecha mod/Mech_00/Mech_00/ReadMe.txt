Hello
Thank you for downloading Mech_00

This asset includes a 3D modular mech character, skinned and animated, 
with modular body set variations, weapons, attachments 
and a full set of animations. 

You can mix different parts, change colors (by given Texture), and 
attach modules to make your own version.

Unity Package included with premade prefabs and script for swapping mech_00 body parts fast and easy.

---
If you import the Unity package:
check the BodySwapperREADME

If you import from scratch:

When importing the FBX , you may notice that the objects Char_Mech(Rig), Core_parts, and Base_parts)
appear at the same level in the hierarchy.
This is normal, some exporters do not preserve the original hierarchy.
You can manually organize them inside your game engine.

---
Hierarchy
---
Each character is made from three main types of objects:
-Base_ (parts) – the three modular body sets.
	Each mesh name includes a prefix such as "Base_S(mall)_Arm" or "Base_L(arge)_Pelvis"
 	so you can easily identify which set it belongs to.
-Core_ (shared parts) – parts that are common to all variants and are used in every combination
	such as "Core_BackJoint" or "Core_Neck".
-Mech_ – the character rig (skeleton).

You can replace the mesh in SkinnedMeshRenderer (Unity) component inside body parts
with meshes named  "Base_(S,M,L)_" to create your own design.

---
Rig-Animations
---
This asset uses a Generic rig (not Humanoid). It can be imported into Unity, Godot, or any other engine that supports FBX skeletons and animations.
For animations that use root motion, assign the bone c_traj as the root bone.

Animations included:(animations runs at 60 fps)
Attack1_L/R
Attack2_L/R
Attack3_L/R
Mech_Shoot1_L/R
Mech_Shoot2_L/R
ShoulderShoot1
ShoulderShoot2
Die
GetHit
Idle
Jump (Jump_Start 0-25, Jump_Mid 25-53, Jump_Land 53-85)
Run / Run_Root
Walk / Walk_Root
Walk L/R / Root
Crouch
Crouch Walk /Crouch Walk_Root
Tpose
The “_L” and “_R” versions indicate left-side and right-side animations.

---
Textures
---
This package requires URP (Universal Render Pipeline).
Materials use URP/Lit and URP/Unlit shaders.

If your project uses HDRP or Built-in pipeline, materials will appear pink.
To fix: select the material → Inspector (top) → change shader to HDRP/Lit or Standard.

MATERIALS
No shader graphs. Simple texture setup:
  • Albedo  → texture
  • Emissive → same texture
Easy to adjust and compatible with any pipeline after a quick shader swap.


All meshes and textures are modular and easy to mix and match.
Each mesh uses two material slots:
Color – for the main look
Outline – for an unlit outline color
In the folder TexturePalettes, you’ll find Simple color pallets textures.
You can apply any of these color textures to any mesh Color Material.
All meshes in the CircuitForms series share the same texture layout, so the palettes are interchangeable.
Core Parts Use same textures but are limited to gray scale.

---
Attachments
---
The rig includes extra bones with suffix "Attachment" on various parts of the Character.
These are used for attaching weapons, armour or other attachments.
To attach a weapon or object:
Locate a bone with suffix "Attachment" and add the attachment as child of that bone and 0.0.0 attachment's transforms (Unity).
or create a BoneAttachment3D node as a child of the Skeleton3D and attach the attachment there (Godot).
For every attachment placement there are 3 bones _S(mal)_, M(edium)_, L(arge), in deferent distances to avoid intersections with the body part.

A script to automate attachment equipping, similar to the body part swapper, may be developed in a future update based on user demand.
---

License: You are free to use this asset in personal and commercial projects (games, apps, software, etc.). You may modify it to suit your needs. You may NOT resell, redistribute, or repackage this asset — modified or unmodified — as a standalone asset or asset pack. Credit is not required but always appreciated in any form.

---

Thank you again for downloading Mech_00.
Please leave feedback or comments if you’d like to see future updates or improvements.
https://jimmys7777.itch.io/
