# pymac.py


clean:
	@echo "Clean"

test:
	./pymac.py tests/mac_1.txt  > aa
	./pymac.py tests/mac_3.txt  >>aa
	./pymac.py tests/mac_5.txt  >>aa
	./pymac.py tests/mac_7.txt  >>aa
	./pymac.py tests/mac_2.txt  >>aa
	./pymac.py tests/mac_4.txt  >>aa
	./pymac.py tests/mac_6.txt  >>aa
	./pymac.py tests/mac_8.txt  >>aa
	diff aa test.org
	rm -f aa

preptest:
	./pymac.py tests/mac_1.txt  > test.org
	./pymac.py tests/mac_3.txt  >>test.org
	./pymac.py tests/mac_5.txt  >>test.org
	./pymac.py tests/mac_7.txt  >>test.org
	./pymac.py tests/mac_2.txt  >>test.org
	./pymac.py tests/mac_4.txt  >>test.org
	./pymac.py tests/mac_6.txt  >>test.org
	./pymac.py tests/mac_8.txt  >>test.org

AUTOCHECK="autocheck"

git: clean
	git add .
	git commit -m "$(AUTOCHECK)"
	git push
#	git push local

