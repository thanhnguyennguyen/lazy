#!/bin/bash
echo Starting local chain ...
gnome-terminal --geometry=150x50 \
--tab  --title="Bootnode"   -- bash -c " cd ~/local_tomo/bootnode && bootnode -nodekey boot.key  " 
echo "Bootnode has been started"

sleep 3s

gnome-terminal --geometry=150x50 \
    --tab  --title="Node1"   -- bash -c " cd ~/local_tomo/node1 && ./start.sh   "  
    echo "Node1 has been started"

    gnome-terminal --geometry=150x50 \
    --tab  --title="Node2"   -- bash -c "cd ~/local_tomo/node2 &&  ./start.sh    "  
    echo "Node2 has been started"
    
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node3"   -- bash -c "cd ~/local_tomo/node3 &&  ./start.sh    "  
    echo "Node3 has been started"
    
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node4"   -- bash -c "cd ~/local_tomo/node4 &&  ./start.sh    "  
    echo "Node4 has been started"
    
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node5"   -- bash -c "cd ~/local_tomo/node5 && ./start.sh    "  
    echo "Node5 has been started"
    
   gnome-terminal --geometry=150x50 \
    --tab  --title="MongoDB Full Node"   -- bash -c "cd ~/local_tomo/node6 && ./start.sh  "  
      echo "MongoDB Full Node has been started"
   
#      gnome-terminal --geometry=150x50 \
#   --tab  --title="Node7"   -- bash -c "cd ~/local_tomo/node7 && ./start.sh    "  
#   echo "Node7 has been started"
#   
#   gnome-terminal --geometry=150x50 \
#   --tab  --title="Node8"   -- bash -c "cd ~/local_tomo/node8 &&  ./start.sh    "  
#   echo "Node8 has been started"
#   
#   gnome-terminal --geometry=150x50 \
#   --tab  --title="Node9"   -- bash -c "cd ~/local_tomo/node9 &&  ./start.sh    "  
#   echo "Node9 has been started"
