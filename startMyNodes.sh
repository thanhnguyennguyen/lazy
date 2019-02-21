#!/bin/bash

gnome-terminal --geometry=150x50 \
--tab  --title="Bootnode"   -- bash -c " cd ~/local_tomo/bootnode && bootnode  -nodekey boot.key  -v5   " 
sleep 5s

if [ "$1" = "fresh" ]
then
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node1"   -- bash -c " cd ~/local_tomo/node1 &&  ./clean.sh && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node2"   -- bash -c "cd ~/local_tomo/node2 &&  ./clean.sh && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node3"   -- bash -c "cd ~/local_tomo/node3 &&  ./clean.sh && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node4"   -- bash -c "cd ~/local_tomo/node4 &&  ./clean.sh && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node5"   -- bash -c "cd ~/local_tomo/node5 &&  ./clean.sh && ./start.sh   "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node6"   -- bash -c "cd ~/local_tomo/node6 &&  ./clean.sh && ./start.sh  "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node7"   -- bash -c "cd ~/local_tomo/node7 &&  ./clean.sh && ./start.sh  "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node8"   -- bash -c "cd ~/local_tomo/node8 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node9"   -- bash -c "cd ~/local_tomo/node9 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node10"   -- bash -c "cd ~/local_tomo/node10 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node11"   -- bash -c "cd ~/local_tomo/node11 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node12"   -- bash -c "cd ~/local_tomo/node12 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node13"   -- bash -c "cd ~/local_tomo/node13 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node14"   -- bash -c "cd ~/local_tomo/node14 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node15"   -- bash -c "cd ~/local_tomo/node15 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node16"   -- bash -c "cd ~/local_tomo/node16 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node17"   -- bash -c "cd ~/local_tomo/node17 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node18"   -- bash -c "cd ~/local_tomo/node18 &&  ./clean.sh && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node19"   -- bash -c "cd ~/local_tomo/node19 &&  ./clean.sh && ./start.sh  "  
else
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node1"   -- bash -c " cd ~/local_tomo/node1  && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node2"   -- bash -c "cd ~/local_tomo/node2  && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node3"   -- bash -c "cd ~/local_tomo/node3  && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node4"   -- bash -c "cd ~/local_tomo/node4  && ./start.sh   "  
    sleep 3s
    gnome-terminal --geometry=150x50 \
    --tab  --title="Node5"   -- bash -c "cd ~/local_tomo/node5  && ./start.sh   "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node6"   -- bash -c "cd ~/local_tomo/node6  && ./start.sh  "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node7"   -- bash -c "cd ~/local_tomo/node7  && ./start.sh  "  
    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node8"   -- bash -c "cd ~/local_tomo/node8  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node9"   -- bash -c "cd ~/local_tomo/node9  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node10"   -- bash -c "cd ~/local_tomo/node10  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node11"   -- bash -c "cd ~/local_tomo/node11  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node12"   -- bash -c "cd ~/local_tomo/node12  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node13"   -- bash -c "cd ~/local_tomo/node13  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node14"   -- bash -c "cd ~/local_tomo/node14  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node15"   -- bash -c "cd ~/local_tomo/node15  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node16"   -- bash -c "cd ~/local_tomo/node16  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node17"   -- bash -c "cd ~/local_tomo/node17  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node18"   -- bash -c "cd ~/local_tomo/node18  && ./start.sh  "  

    # sleep 3s
    # gnome-terminal --geometry=150x50 \
    # --tab  --title="Node19"   -- bash -c "cd ~/local_tomo/node19  && ./start.sh  "  

fi
