gnome-terminal --geometry=150x50 \
--tab  --title="Bootnode" -e 'bash -c " cd ~/local_tomo/bootnode && bootnode --nodekey=boot.key ;exec bash " '
sleep 5s
gnome-terminal --geometry=150x50 \
--tab  --title="Node1" -e 'bash -c " cd ~/local_tomo/node1 &&  ./clean.sh && ./start.sh ;exec bash " ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node2" -e 'bash -c "cd ~/local_tomo/node2 &&  ./clean.sh && ./start.sh ;exec bash " ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node3" -e 'bash -c "cd ~/local_tomo/node3 &&  ./clean.sh && ./start.sh ;exec bash " ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node4" -e 'bash -c "cd ~/local_tomo/node4 &&  ./clean.sh && ./start.sh ;exec bash " ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node5" -e 'bash -c "cd ~/local_tomo/node5 &&  ./clean.sh && ./start.sh ;exec bash " ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node6" -e 'bash -c "cd ~/local_tomo/node6 &&  ./clean.sh && ./start.sh ;exec bash" ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node7" -e 'bash -c "cd ~/local_tomo/node7 &&  ./clean.sh && ./start.sh ;exec bash" ' 
sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node8" -e 'bash -c "cd ~/local_tomo/node8 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node9" -e 'bash -c "cd ~/local_tomo/node9 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node10" -e 'bash -c "cd ~/local_tomo/node10 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node11" -e 'bash -c "cd ~/local_tomo/node11 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node12" -e 'bash -c "cd ~/local_tomo/node12 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node13" -e 'bash -c "cd ~/local_tomo/node13 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node14" -e 'bash -c "cd ~/local_tomo/node14 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node15" -e 'bash -c "cd ~/local_tomo/node15 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node16" -e 'bash -c "cd ~/local_tomo/node16 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node17" -e 'bash -c "cd ~/local_tomo/node17 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node18" -e 'bash -c "cd ~/local_tomo/node18 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node19" -e 'bash -c "cd ~/local_tomo/node19 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Node20" -e 'bash -c "cd ~/local_tomo/node20 &&  ./clean.sh && ./start.sh ;exec bash" ' 

sleep 3s
gnome-terminal --geometry=150x50 \
--tab  --title="Open lazy tool" -e 'bash -c  "cd ~/git/lazy && ;exec bash"'
