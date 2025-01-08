public with sharing class Calculator {
    public Calculator() {

    }

    public Integer Add(Integer a, Integer b){
        return a + b;
    }

    public Integer Multiply(Integer a, Integer b){
        Integer sum = 0;

        for(Integer i = 0; i < a; i++){
            sum = Add(sum, b);
        }

        return sum;
    }

    public Integer Divide(Integer a, Integer b){
        if(b == 0) return 0;

        Integer sum = a;
        Integer count = 0;

        while(sum > b){
            sum = Add(sum, -b);

            count++;
        }

        return count;
    }

    public Integer Mod(Integer a, Integer b){

        Integer sum = a;

        while(sum >= b){
            sum = Add(sum, -b);
        }

        return sum;
    }
}