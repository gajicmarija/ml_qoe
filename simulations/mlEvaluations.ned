// Hierarchical Token Bucket Implementation for OMNeT++ & INET Framework
// Copyright (C) 2021 Marija Gajić (NTNU), Marcin Bosk (TUM), Susanna Schwarzmann (TU Berlin), Stanislav Lange (NTNU), and Thomas Zinner (NTNU)
// 
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
// 

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.common.IntegratedVisualizer;
import inet.node.internetcloud.InternetCloud;

package ml_qoe.simulations;

//import inet.applications.generic.linkAdjuster;

network mlEvaluations
{
    parameters:
        @display("bgb=900,500");
        int nVID = default(1); // Number of video clients
        int nLVD = default(1); // Number of live video clients
        int nFDO = default(1); // Number of file download clients
        int nSSH = default(1); // Number of SSH clients
        int nVIP = default(1); // Number of VoIP clients
    types:
        channel C extends DatarateChannel
        {
        }
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=10,10;is=s");
        }
        hostVID[nVID]: StandardHost;
        hostLVD[nLVD]: StandardHost;
        hostFDO[nFDO]: StandardHost;
        hostSSH[nSSH]: StandardHost;
        hostVIP[nVIP]: StandardHost;
        router0: Router {
            @display("p=300,250");
        }
        router1: Router {
            @display("p=600,250");
        }
        visualizer: IntegratedVisualizer {
            @display("p=18,71");
        }
        serverVID: StandardHost {
            @display("p=750,50");
        }
        serverLVD: StandardHost {
            @display("p=750,150");
        }
        serverFDO: StandardHost {
            @display("p=750,250");
        }
        serverSSH: StandardHost {
            @display("p=750,350");
        }
        serverVIP: StandardHost {
            @display("p=750,450");
        }
    connections:
        router0.pppg++ <--> connFIX0: C { datarate = 100Mbps; delay = 1ms; } <--> router1.pppg++;

        for i=0..nVID-1 {
            hostVID[i].pppg++ <--> C {  datarate = 1Gbps; delay = 100ns; } <--> router0.pppg++;
        }
        for i=0..nLVD-1 {
            hostLVD[i].pppg++ <--> C {  datarate = 1Gbps; delay = 100ns; } <--> router0.pppg++;
        }
        for i=0..nFDO-1 {
            hostFDO[i].pppg++ <--> C {  datarate = 1Gbps; delay = 100ns; } <--> router0.pppg++;
        }
        for i=0..nSSH-1 {
            hostSSH[i].pppg++ <--> C {  datarate = 1Gbps; delay = 100ns; } <--> router0.pppg++;
        }
        for i=0..nVIP-1 {
            hostVIP[i].pppg++ <--> C {  datarate = 1Gbps; delay = 100ns; } <--> router0.pppg++;
        }
        serverVID.pppg++ <--> C {  datarate = 10Gbps; delay = 100ns; } <--> router1.pppg++;
        serverLVD.pppg++ <--> C {  datarate = 10Gbps; delay = 100ns; } <--> router1.pppg++;
        serverFDO.pppg++ <--> C {  datarate = 10Gbps; delay = 100ns; } <--> router1.pppg++;
        serverSSH.pppg++ <--> C {  datarate = 10Gbps; delay = 100ns; } <--> router1.pppg++;
        serverVIP.pppg++ <--> C {  datarate = 10Gbps; delay = 100ns; } <--> router1.pppg++;
}