public with sharing abstract class Vehicle {

    public final Integer Capacity;

    public enum Medium{
        LAND, AIR, WATER
    }

    protected List<Medium> Media = new List<Medium>();

    public Decimal Speed {
        get{return Speed;}
        protected set{
            try{
                if(value < 0){
                    throw new CustomException('Speed cannot be negative');
                }
                else{
                    Speed = value;
                }
            }
            catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }

    public String Name{get; private set;}

    public Integer Occupants {
        get{return Occupants;}
        set{
            try{
                if(value < 0){
                    throw new CustomException('Occupants cannot be negative');
                }
                else{
                    Occupants = value;
                }
            }
            catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    } 

    public Vehicle() {
        this.Speed = 1;
        this.Name = 'Vehicle';
        this.Occupants = 0;
        this.Capacity = 1;
    }

    public Vehicle(Decimal Speed, String Name, Integer Occupants, Integer Capacity, List<Medium> Media) {
        this.Speed = Speed;
        this.Name = Name;
        this.Occupants = Occupants;
        
        try{
            if(Capacity < 1){
                throw new CustomException('Capacity must be at least 1');
            }
            else{
                this.Capacity = Capacity;
            }
                
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }

        this.Media = Media;
    }


    public virtual void Accelerate(Decimal amount){
        Speed += amount;
    }

    public abstract void Turn(Decimal degrees);

    public override String ToString(){
        String val = 'Speed: ' + Speed + '\n' +
            'Occupants: ' + Occupants + '\n' +
            'Name: ' + Name + '\n' + 'Media:\n';

        for(Medium m : Media){
            val += '\t' + m.name() + '\n';
        }

        return val;
    }

}