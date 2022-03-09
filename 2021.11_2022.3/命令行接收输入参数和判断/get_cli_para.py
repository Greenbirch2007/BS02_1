import sys
# input_parametre = None


if __name__:= "__main__":


    try:
        input_parametre = list(sys.argv)[1]
        if input_parametre not in ("a","b"):
            print("pleaes input  a or b !")
            sys.exit(0)
    except BaseException as e:
        print("pleaes input  a or b !")
        sys.exit(0)

    if input_parametre == "a" or input_parametre == "b":
        print("success")