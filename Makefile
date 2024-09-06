NIXOSCFG=$(shell pwd)

.PHONY: deploy \
	zellij-test zellij-clean \
	alacritty-test alacritty-clean \

deploy:
	nixos-rebuild switch --flake $(NIXOSCFG)#laptop

# debug dotfiles
zellij-clean:
	rm -rf $(HOME)/.config/zellij

zellij-test: zellij-clean
	rsync -avz --copy-links --chmod=D2755,F744 ./home/terminal/zellij/ $(HOME)/.config/zellij

alacritty-clean:
	rm -rf $(HOME)/.config/alacritty

alacritty-test: alacritty-clean
	rsync -avz --copy-links --chmod=D2755,F744 ./home/terminal/alacritty/ $(HOME)/.config/alacritty


