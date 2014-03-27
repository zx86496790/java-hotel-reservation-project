/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package beans;

/**
 *
 * @author zsen
 */
public class Room {
    private String roomId;
    private String floor;
    private double price;
    private String specification;

    public Room(String roomId, String floor, double price, String specification) {
        this.roomId = roomId;
        this.floor = floor;
        this.price = price;
        this.specification = specification;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }
    public String toString()
    {
        return "Room "+roomId+" in floor "+floor+"'s price is "+price+" detalis is "+specification;
    }
}
