public with sharing class Car extends Vehicle {

    private Decimal SteeringRotation = 0;

    public Car() {
        super();
        TireRotation = 0;
        SteeringRotation = 0;
        Media.add(Medium.LAND);
    }

    public Car(Decimal Speed, String Name, Integer Occupants, Integer Capacity, List<Medium> Media, Decimal TireRotation, Decimal SteeringRotation){
        super(Speed, Name, Occupants, Capacity, Media);
        this.TireRotation = TireRotation;
        this.SteeringRotation = SteeringRotation;
    }

    public Decimal TireRotation{
        get{return TireRotation;}
        private set{
            try{
                if(value < -90 || value > 90){
                    throw new CustomException('TireRotation must be between -90 and 90');
                }
                else{
                    TireRotation = value;
                }
                
            }
            catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }

    public Integer Gear{
        get;
        private set;
    }

    public override void Turn(Decimal degrees){
        Decimal newSteeringVal = SteeringRotation + degrees;

        try{
            if(newSteeringVal < -1440 || newSteeringVal > 1440){
                throw new CustomException('SteeringRotation must be between -1440 and 1440');
            }
            else{
                SteeringRotation = newSteeringVal;
            }
        }
        catch(Exception e){
            return;
        }

        TireRotation = SteeringRotation / 16;
    }

    public override void Accelerate(Decimal amount){
        Speed += amount;
        Gear = (Integer)Math.ceil(0.4444 * (Math.sqrt(Speed)));
    }

}