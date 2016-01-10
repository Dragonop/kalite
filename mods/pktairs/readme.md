pktairs mod by PEAK
===================

a fork of [tairs](https://forum.minetest.net/viewtopic.php?f=9&t=11974)
by AllenLim012

description:
------------
- code reorganised, so it’s easy to add more materials and items
	and change the nodeboxes
- standardised craft recipes
- nodebox for chairs rotated and slightly modified
- added more materials
- hence more dependencies: wool and farming
  (and as example for materials from other mods: cottages?)
- added Stools and Bedside Tables (nodeboxes from lottblocks)
- added (default-) sounds

crafting:
---------

by default available materials  
(not all items are available in all these materials):

- default:wood
- default:junglewood
- default:pine_wood
- default:acacia_wood
- default:tree
- default:stone
- default:cobble
- farming:straw
- wool:red (only a chair)
- (cottages:reet)
- (cottages:slate_vertical)



### Chairs:
		material        -          -
		material        material   -
		default:stick   -          default:stick


### Tables:
		material   material             material
		-          default:fence_wood   -
		-          default:fence_wood   -


### Shelves:
		material   material             material
		material   default:fence_wood   material
		material   default:fence_wood   material


### Stools:
		-               -          material
		-               material   material
		default:stick   -          default:stick

### Bedside Tables:
		-               -          -
		material        material   material
		default:stick   -          default:stick

depedencies:
------------
default  
wool  
farming  
cottages? (as example)

credits:
--------
- AllenLim012 for the original mod
- The makers of LotT for the stool and bedside table nodeboxes

license:
--------
WTFPL

_PEAK_ 2015-12-03

