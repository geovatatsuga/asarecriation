with open('servers/world_server.py', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find the first and second instance of '_init_database'
first_idx = -1
for idx, line in enumerate(lines):
    if 'def _init_database(self):' in line:
        first_idx = idx
        break

second_idx = -1
for idx, line in enumerate(lines[first_idx+1:], start=first_idx+1):
    if 'def _init_database(self):' in line:
        second_idx = idx
        break

print("first _init_database:", first_idx)
print("second _init_database:", second_idx)

if first_idx != -1 and second_idx != -1:
    # Remove from first_idx to second_idx (exclusive)
    print(f"Removing lines from {first_idx} to {second_idx}")
    new_lines = lines[:first_idx] + lines[second_idx:]
    with open('servers/world_server.py', 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print("Success!")
else:
    print("No duplicates found.")
