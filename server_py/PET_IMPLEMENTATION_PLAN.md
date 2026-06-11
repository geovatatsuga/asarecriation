# Pet System Implementation Plan for Asa de Cristal Server

## Current State
- **Implemented**: PET_VIEW_REQUEST (5378) and sends PET_CHECK_NOTIFY (5377)
- **Location**: `server_py/handlers/pet_handler.py`
- **Missing**: 16 pet commands from client ActionScript

## Data Storage Analysis
From `player_data_manager.py`, pet-related fields appear to be:
- Stored in player data but not fully implemented in current handlers
- Need to examine how pet data is structured in database/player state

## Command Analysis

### Based on naming conventions and similar systems:

#### Request Commands (C→S) - Server needs to process:
1. **PET_RENAME_REQUEST** (5380) - Rename pet
   - Likely carries: pet_id, new_name
   - Response: PET_CHECK_NOTIFY or specific answer

2. **PET_FORGET_SKILL_REQUEST** (5381) - Make pet forget a skill
   - Likely carries: pet_id, skill_id
   - Response: PET_CHECK_NOTIFY or PET_FORGET_SKILL_ANSWER

3. **PET_ASSIGN_ATTR_REQUEST** (5382) - Assign attribute points to pet
   - Likely carries: pet_id, attribute_type, points
   - Response: PET_CHECK_NOTIFY or PET_ASSIGN_ATTR_ANSWER

4. **PET_LEARN_SKILL_REQUEST** (5383) - Pet learns a skill
   - Likely carries: pet_id, skill_id
   - Response: PET_LEARN_SKILL_ANSWER (5384)

5. **PLAYER_SET_PET_ACTION_MODE_REQUEST** (5411) - Set pet's action mode (passive/active/defensive)
   - Likely carries: pet_id, mode
   - Response: PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY (5412)

6. **PET_ENHANCE_REQUEST** (5413) - Enhance/upgrade pet
   - Likely carries: pet_id, enhancement materials
   - Response: PET_ENHANCE_ANSWER (5414)

7. **PET_FUSION_REQUEST** (5415) - Fuse two pets
   - Likely carries: pet_id1, pet_id2, fusion materials
   - Response: PET_FUSION_ANSWER (5416)

8. **PET_REMOVE_EQUIPMENT_REQUEST** (5424) - Remove equipment from pet
   - Similar to player equipment removal
   - Likely carries: pet_id, equipment_slot
   - Response: PET_CHECK_NOTIFY or specific answer

9. **PET_DECOMPOSE_REQUEST** (5431) - Decompose pet for resources
   - Likely carries: pet_id
   - Response: PET_CHECK_NOTIFY or specific answer with resources

#### Notify Commands (S→C) - Server needs to send:
1. **PET_ATTR_INT_CHANGE_NOTIFY** (5379) - Pet attribute changed
   - Triggered when pet stats change (level up, item use, etc.)

2. **PET_USE_SKILL_NOTIFY** (5409) - Pet used a skill
   - Similar to PLAYER_USE_SKILL_REQ but for pets

3. **PET_HP_CHANGE_NOTIFY** (5410) - Pet HP changed
   - Sent when pet takes damage or heals

4. **PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY** (5412) - Pet action mode changed
   - Response to PLAYER_SET_PET_ACTION_MODE_REQUEST

## Implementation Strategy

### 1. Extend PetHandler class
- Add handler mappings for all missing commands
- Implement handler functions following existing patterns

### 2. Data Structure
- Need to store pet data in player_data or separate pet manager
- Each pet should have: id, code/name, level, exp, hp, mp, stats, skills, equipment, loyalty, etc.

### 3. Handler Patterns to Follow:
- Request handlers: Read data from PacketReader, validate, update state, send response
- Notify functions: Build PacketBuilder with data, send appropriate command
- Use existing write_pet_attributes and write_pet_full_info as templates

### 4. Priority Order:
1. Basic pet management: rename, view (already partial), action modes
2. Skill system: learn, forget, use
3. Stat system: attribute assignment, HP changes
4. Advanced: enhancement, fusion, equipment
5. Resource: decomposition

## Sample Implementation Template:
```python
def handle_pet_rename_request(self, reader: PacketReader):
    pet_id = reader.read_string()
    new_name = reader.read_string()
    # Validate pet exists and belongs to player
    # Update pet name in player data
    # Send confirmation (PET_CHECK_NOTIFY or specific answer)
    
def handle_pet_learn_skill_request(self, reader: PacketReader):
    pet_id = reader.read_string()
    skill_id = reader.read_int()  # or varint
    # Check if pet can learn skill, has required items/level
    # Add skill to pet's skill list
    # Send PET_LEARN_SKILL_ANSWER with result
```

## Files to Modify:
1. `server_py/handlers/pet_handler.py` - Main implementation
2. Possibly `player_data_manager.py` - If pet storage needs extension
3. May need new utility functions for pet data handling

## Testing Approach:
1. Verify existing PET_VIEW_REQUEST still works
2. Test each new command individually with packet sender
3. Validate data persistence and client-side updates
4. Check for proper error handling and edge cases