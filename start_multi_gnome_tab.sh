gnome-terminal --geometry=150x50 \
--tab  --title="Bootnode" -e 'bash -c " cd ~/local_tomo/bootnode && bootnode --nodekey=boot.key ;exec bash " '
sleep 5s
gnome-terminal --geometry=150x50 \
--tab  --title="Node1" -e 'bash -c " cd ~/local_tomo/node1 && ./start.sh ;exec bash " ' \
--tab  --title="Node2" -e 'bash -c "cd ~/local_tomo/node2 && ./start.sh ;exec bash " ' \
--tab  --title="Node3" -e 'bash -c "cd ~/local_tomo/node3 && ./start.sh ;exec bash " ' \
--tab  --title="Node4" -e 'bash -c "cd ~/local_tomo/node4 && ./start.sh ;exec bash " ' \
--tab  --title="Node5" -e 'bash -c "cd ~/local_tomo/node5 && ./start.sh ;exec bash " ' \
--tab  --title="Node6" -e 'bash -c "cd ~/local_tomo/node6 && ./start.sh ;exec bash" ' \
--tab  --title="Node7" -e 'bash -c "cd ~/local_tomo/node7 && ./start.sh ;exec bash" ' \
--tab  --title="Node8" -e 'bash -c "cd ~/local_tomo/node8 && ./start.sh ;exec bash" ' \
--tab  --title="Open lazy tool" -e 'bash -c  "cd ~/git/lazy && ;exec bash"'
